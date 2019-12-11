import json
import pandas as pd
import numpy as np
import dash
import dash_core_components as dcc
import dash_html_components as html
from dash.exceptions import PreventUpdate
import plotly.graph_objects as go
import dash_table
import dash_bootstrap_components as dbc

import os
from os import environ   
from sqlalchemy import create_engine

my_user    = os.environ.get(‘DB_USER’)
my_passwd  = os.environ.get(‘DB_USER_PASSWORD’)
my_db_port = os.environ.get(‘DB_PORT’)
my_host_endpoint =  os.environ.get(‘DB_ENDPOINT_HOST’)
my_db      = os.environ.get(‘DB_NAME’)
sql_conn_str=‘postgresql://‘+my_user+‘:’+my_passwd+‘@’+my_host_endpoint+‘:’+my_db_port+‘/’+my_db
#Connect to PostgreSQL database
engine = create_engine(sql_conn_str)

with open('geojsons/colombia-dptos.geo.json', 'rb') as input:
    colombia_json = json.load(input)

with open('geojsons/colombia-mpios.geo.json', 'rb') as input:
    colombia_mpios_json = json.load(input)

year_marks = {}
for year in range(1998,2018):
    year_marks[year] = str(year)

conn = engine.connect()

columnas_afecciones = ["muertos","personas","familias", "viviendas_destruidas", "viviendas_averiadas"]

df_deptos = pd.read_sql("""
    select d.cod_departamento, d.departamento, ri.porc_pob_expuesta
        from riesgo_indices ri
            inner join divipola d on (d.divipola_id = ri.divipola_id)
        where cod_municipio is null
        order by d.departamento""", conn)

df_indices = pd.read_sql("""
    select d.divipola_id, d.municipio, d.cod_departamento, d.departamento, 
        ri.indice_capacidades, ri.distancia_euclidiana, ri.indice_riesgo, ri.indice_riesgo_ajustado_cap, ri.ranking_inidice_riesgo_aj
    from riesgo_indices ri
        inner join divipola d on (d.divipola_id = ri.divipola_id)
    where cod_municipio is not null
    """, conn)

df_desastres = pd.read_sql("""
    select date_trunc('year',hd.fecha) as fecha_ano, d.divipola_id, d.municipio, d.cod_departamento, d.departamento,
        sum(muertos) muertos,sum(personas) personas,sum(familias) familias,
        sum(viviendas_destruidas) viviendas_destruidas, sum(viviendas_averiadas) viviendas_averiadas
    from historico_desastres hd
        inner join divipola d on (d.divipola_id = hd.divipola_id)
    group by date_trunc('year',hd.fecha), d.divipola_id, d.municipio, d.cod_departamento, d.departamento
    """, conn)

df_temperaturas = pd.read_sql("""
    select cast(date_trunc('month',hc.fecha) as date) as mes_condicion, hc.min_temp, hc.max_temp, hc.precipitacion
    from divi_hist_cond_met dh 
        inner join historico_cond_meteorologicas hc on (hc.id = dh.hist_cond_met_id)
    order by cast(date_trunc('month',hc.fecha) as date);
""", conn)

df_desastres["año"] = df_desastres.fecha_ano.dt.year

df_desastres_nacional = df_desastres.fillna(0).groupby("año")[columnas_afecciones].sum()

df_temperaturas["mes"] = pd.to_datetime(df_temperaturas.mes_condicion).dt.month


df_deptos.fillna(0, inplace = True)

layout_map = dict(
        mapbox=dict(
            style="carto-positron",
            center = {"lat": 4.570868, "lon": -74.2973328},
            zoom=4,
            ),
        margin={'t': 30, 'l': 0, 'r': 0, 'b': 0},
        title="% Población expuesta por Departamento",
    )

dptos_graph_data = [
                go.Choroplethmapbox(
                    geojson=colombia_json,
                    locations=df_deptos['cod_departamento'],
                    z=df_deptos['porc_pob_expuesta'],
                    zmax=100,
                    zmin=0,
                    colorscale='Hot',
                    reversescale=True,
                    text=df_deptos['departamento'],
                    customdata=df_deptos['cod_departamento'],
                        )]



app = dash.Dash(__name__, external_stylesheets=[dbc.themes.BOOTSTRAP])


app.layout = html.Div(children=[


        dbc.Row(
            [
                dbc.Col([
                    dcc.Input(id='divipola', type='text', value='colombia', style={'display': 'none'})
                    ],md=1),                
                dbc.Col(
                    [
                        dcc.Dropdown(
                            id="indicador",
                            value='indice',
                            options=[
                                {'label': 'Indice de Riesgo', 'value': 'indice'},
                                {'label': 'Personas Afectadas', 'value': 'personas'},
                                {'label': 'Familias Afectadas', 'value': 'familias'},
                                {'label': 'Muertos', 'value': 'muertos'},
                                {'label': 'Viviendas Destruidas', 'value': 'viviendas_destruidas'},
                                {'label': 'Viviendas Averiadas', 'value': 'viviendas_averiadas' },
                            ],
                            style={'display': 'none'}
                        )
                    ],
                    md=4,
                ),
                dbc.Col(
                    [
                        html.H2("Mapa Integrado Información de Riesgo"),
                    ],
                    md=6,
                ),
                dbc.Col([],md=1),
            ]
        ),
        dbc.Row(
            [
                dbc.Col(
                    [
                        dcc.Graph(id="mapa",
                            figure = dict(data= dptos_graph_data, layout=layout_map)
                        ),
                        html.H6("Seleccione el rango de años deseado"),
                        dcc.RangeSlider(
                            id='year-range-slider',
                            min=1998,
                            max=2018,
                            step=1,
                            marks = year_marks,
                            value=[1998, 2018]
                        ),
                        html.Div(id="map2")
                    ],
                    md=6,
                ),
                dbc.Col(
                    [
                        html.Div(id="graficos-derecha",
                            children =[
                                dcc.Graph(id="stackbar",
                                    figure = {'data': [
                                        go.Bar(
                                            name='Personas Afectadas', 
                                            x=df_desastres_nacional.index, 
                                            y=df_desastres_nacional["personas"], 
                                            marker_color='orange',
                                            ),    
                                        go.Bar(
                                            name='Familias Afectadas', 
                                            x=df_desastres_nacional.index, 
                                            y=df_desastres_nacional["familias"],
                                            marker_color='orange',
                                            visible = "legendonly"
                                            ),    
                                        go.Bar(
                                            name='Muertos', 
                                            x=df_desastres_nacional.index, 
                                            y=df_desastres_nacional["muertos"],
                                            marker_color='rgb(227,26,28)',
                                            visible = "legendonly"

                                            ),    
                                        go.Bar(
                                            name='Viviendas Averiadas', 
                                            x=df_desastres_nacional.index, 
                                            y=df_desastres_nacional["viviendas_averiadas"],
                                            marker_color='yellow',
                                            visible = "legendonly"
                                            ),    
                                        go.Bar(
                                            name='Viviendas Destruidas', 
                                            x=df_desastres_nacional.index, 
                                            y=df_desastres_nacional["viviendas_destruidas"],
                                            marker_color='brown',
                                            visible = "legendonly"
                                            ),                                
                                        ],
                                    'layout' : go.Layout(
                                        #barmode='stack',
                                        legend_orientation="h",
                                        title="Afectaciones",
                                        height=400
                                        )
                                    }  

                                    ),
                                ]
                            )
                    ]
                ),
            ]
        )
    ],
)    


## Callback Dropdown indicador
@app.callback(
        (dash.dependencies.Output('indicador', 'style')
         ),
        [
        dash.dependencies.Input('divipola', 'value'),
        ]
    )
def show_dropdown(divipola):
    if divipola != "colombia":
        return {'display': 'block'}


## Callback de Mapa
@app.callback(
        (dash.dependencies.Output('mapa', 'figure')
         ),
        [
        dash.dependencies.Input('year-range-slider', 'value'),
        dash.dependencies.Input('indicador', 'value'),
        dash.dependencies.Input('divipola', 'value'),
        ]
    )

def update_map_plot(year_range, indicador, divipola):

    print(indicador, divipola)

    if divipola=="colombia": #Mapa de Colombia por departamentos
        raise PreventUpdate

    elif len(divipola) == 2: #Cargar Mapa de Departamento

        df_centrodptos = pd.read_csv('geojsons/centrosdepartamentoscolombia.csv', dtype={"id":"str"})
        df_centrodptos = df_centrodptos.set_index("id")

        layout_map = dict(
            mapbox=dict(
                style="carto-positron",
                center = {"lat": df_centrodptos.loc[divipola]["latitud"], "lon": df_centrodptos.loc[divipola]["longitud"]},
                zoom=df_centrodptos.loc[divipola]["zoom"],
                ),
            margin={'t': 30, 'l': 0, 'r': 0, 'b': 0},
            title="% Población expuesta por Departamento",
        )

        df_indices_filtrado = df_indices[df_indices['cod_departamento']==divipola]
        
        if indicador == 'indice':
            z = df_indices_filtrado["indice_riesgo_ajustado_cap"]
            zmax = 100
        else:
            df_desastres_filtrado_dpto = df_desastres[ (df_desastres['cod_departamento'] == divipola) & (df_desastres['año'] >= year_range[0]) & (df_desastres['año'] <= year_range[1])].groupby(["divipola_id"])[columnas_afecciones].sum()


            if indicador == 'personas':
                z = df_desastres_filtrado_dpto["personas"]
                zmax = df_desastres_filtrado_dpto["personas"].max()
            elif indicador == 'familias':
                z = df_desastres_filtrado_dpto["familias"]
                zmax = df_desastres_filtrado_dpto["familias"].max()
            elif indicador == 'muertos':
                z = df_desastres_filtrado_dpto["muertos"]
                zmax = df_desastres_filtrado_dpto["muertos"].max()
            elif indicador == 'viviendas_destruidas':
                z = df_desastres_filtrado_dpto["viviendas_destruidas"]
                zmax = df_desastres_filtrado_dpto["viviendas_destruidas"].max()
            elif indicador == 'viviendas_averiadas':
                z = df_desastres_filtrado_dpto["viviendas_averiadas"]
                zmax = df_desastres_filtrado_dpto["viviendas_averiadas"].max()

        dpto_graph_data = [
                go.Choroplethmapbox(
                    geojson=colombia_mpios_json,
                    locations=df_indices_filtrado["divipola_id"],
                    z=z,
                    zmax=zmax,
                    zmin=0,
                    colorscale='Hot',
                    reversescale=True,
                    text=df_indices_filtrado["municipio"],
                    customdata=df_indices_filtrado['divipola_id'],
                        )]
        return {"data":dpto_graph_data, "layout":layout_map}

    elif len(divipola) == 5:
        raise PreventUpdate

##Callback hidden input divipola
@app.callback(
        (dash.dependencies.Output('divipola', 'value')
         ),
        [
        dash.dependencies.Input('mapa', 'clickData')
        ]
    )

def update_divipola(clickData):
    if clickData is None:
        raise PreventUpdate
    else:
        print(clickData)
        return clickData["points"][0]["customdata"]

## Callback de Grafico de Barras
@app.callback(
        (dash.dependencies.Output('graficos-derecha', 'children')
         ),
        [
        dash.dependencies.Input('year-range-slider', 'value'),
        dash.dependencies.Input('indicador', 'value'),
        dash.dependencies.Input('divipola', 'value'),
        ]
)
def update_bar_plots(year_range, indicador, divipola):

    #Mapa de Colombia por departamentos
    if divipola=="colombia": 
        df_desastres_filtrado = df_desastres_nacional

    elif len(divipola) == 2:
        df_desastres_filtrado = df_desastres[ (df_desastres['cod_departamento'] == divipola) & (df_desastres['año'] >= year_range[0]) & (df_desastres['año'] <= year_range[1])].groupby("año")[columnas_afecciones].sum()

    elif len(divipola) == 5:
        df_desastres_filtrado = df_desastres[ (df_desastres['divipola_id'] == divipola) & (df_desastres['año'] >= year_range[0]) & (df_desastres['año'] <= year_range[1])].groupby("año")[columnas_afecciones].sum()
        

        ### CREAR GRAFICO DE TEMPERATURA
        ##########. TODO
        grafico_temp = dcc.Graph(id="tempplot", figure = {})

        



    grafico_barras = dcc.Graph(id="stackbar",
    figure = {
        'data': [
            go.Bar(
                name='Personas Afectadas', 
                x=df_desastres_filtrado.index, 
                y=df_desastres_filtrado["personas"], 
                marker_color='orange',
                ),    
            go.Bar(
                name='Familias Afectadas', 
                x=df_desastres_filtrado.index, 
                y=df_desastres_filtrado["familias"],
                marker_color='orange',
                visible = "legendonly"
                ),    
            go.Bar(
                name='Muertos', 
                x=df_desastres_filtrado.index, 
                y=df_desastres_filtrado["muertos"],
                marker_color='rgb(227,26,28)',
                visible = "legendonly"

                ),    
            go.Bar(
                name='Viviendas Averiadas', 
                x=df_desastres_filtrado.index, 
                y=df_desastres_filtrado["viviendas_averiadas"],
                marker_color='yellow',
                visible = "legendonly"
                ),    
            go.Bar(
                name='Viviendas Destruidas', 
                x=df_desastres_filtrado.index, 
                y=df_desastres_filtrado["viviendas_destruidas"],
                marker_color='brown',
                visible = "legendonly"
                ),                                
            ],
        'layout' : go.Layout(
            #barmode='stack',
            legend_orientation="h",
            title="Afectaciones",
            height=400
            )
        })
    
    if len(divipola) != 5:
        return grafico_barras
    else:
        return [grafico_barras, grafico_temp]




if __name__ == "__main__":
    app.run_server(debug=True, host='0.0.0.0')
