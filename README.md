#  Integrated Risk Information Map in Colombia - Final Project 
#  Datascience for All (DS4A) - Team 03: 

Datascience for All (DS4A) - Integrated Risk Information Map - Final Project - Group 3: December 2019

Integrated Risk Information Map in Colombia - Mapa Integrado Información de Riesgo en Colombia

Mario Cerón, Johnathan Salamanca, Carol Martinez, Javier Cocunubo, Jairo Niño, Alvaro Muñoz

#Repositories: 

https://github.com/marioceron/DS4A_Integrated_Risk_Information_Map_Final_Project_Team03_2019

https://github.com/jssalamanca1967/ds4a_finalgroup_group03/

# Introduction: 


Integrated Risk Information Map in Colombia:

Present the development process of the tool called: Integrated Map of Risk Information in Colombia.
It presents key information of the general situation of the country in terms of risk and can be used as a tool to guide future decisions in the different regions.

The Dashboard Web Application, the team expects to enable any person to find, read and understand the basic risk profile of their region of interest and also understand about climate associated risks. All this based on open data philosophy.
The work is set up to do 3 things:

• Find historic evidence of those claims.

• Create an index to capture and monitor that imbalance in the allocation of coping capabilities and resources.

• Offer actionable information to both the general public and administration officials to improve their understanding of future impact of climatic events.

The developed tool could be of value for the people in general, outside our regular interests, activities and industries.

# Datasets sourced:

The main dataset used in the project is from the Colombia Risk of Disaster Management Unit (Unidad de Gesti ́on de Riesgos y Desastres) UNGRD. 

The dataset contains information about the risk management associated with natural phenomena, socio-natural, technologic, and human- based non-intentional incidents reported in Colombia in the last 10 years (38626 records). Some of the fields found in the dataset are: Date, Department, Municipality, Event Name, Code, Dead, Wounded, Disappeared, Affected People, Affected Families, Affected Houses, among others.

Also use a dataset from the National Administrative Department for Statistics DANE. It is a time series between 1985 to 2020 and contains demographic information, per depart- ment code.


# Folders:

# /aws_diagrams: 
* AWS deployment and component diagram, ER Model and flow chart of Python Dash app

# /code
* /dash: Relevante code of the Python Dash app (app.py); to usage: run local ´python app.py´
* /dash/geojsons: include 3 files : colombia-dptos.geo.json, colombia-mpios.geo.json, colombia_limpio.geojson
(Divipola: Colombian political division: Departments and municipalities)

* /html: Static content (welcome page)

# /datasets: 
* CSV files with datasets: divipola, lattitude_longuitud,demographics, temperatures and precipitation
* Database: 7 tables: divipola, eventos, riesgo_indices, historico_desastres, estimacion_poblaciones, historico_cond_meteorologicas, divi_hist_cond_met; and one view: vw_desastres

# /latexDocuments: 
* /project: Reports and images in Latex format and PDF format: Report_project_final.pdf 
and 5 incremental deliveries versions of the report.

# /presentation: 
* pptx presentation, movie and animated gif.

# Presentation :

Animated Gif with the presentation:

![Final Project Presentation](presentation/Bogota_Group_03_Presentation.gif)

# AWS Component Diagram:

![AWS Component Diagram Integrated Risk Map](aws_diagrams/AWS_Component_Diagram_project_group_03.jpg)

# Entity Relationsip (ER) Model - Integrated Risk Information Map:

![ER relationship Model Integrated Risk Map](aws_diagrams/Project_Group03_ERModel.jpg)

# Jupyter Notebook with Exploratory Data Analysis (HTML stored in S3 bucket):

Disasters dataset integration:

https://marioceron-case-51.s3.amazonaws.com/final_project/Disaster_DataSets_Integration.html

Disaster exploratory analysis: 

https://marioceron-case-51.s3.amazonaws.com/final_project/disaster-exploration.html


# Final Report:

https://github.com/marioceron/DS4A_Integrated_Risk_Information_Map_Final_Project_Team03_2019/blob/9186c94952e4d93369de00f5b391a45f95d85d05/latexDocuments/project/Report_project_final.pdf
