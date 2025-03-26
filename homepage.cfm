<cfset setLocale("pt_BR")>

<cfinvoke component="med_project.components" method="getMedicos" returnvariable="listarMedicos">

<html lang="pt">
    <head>
        <title>DBC Saúde</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="_css/styles_homepage.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Montserrat:wght@600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <main>
            <h1>DBC Saúde</h1>
            
            <a href="consultas_agendadas.cfm" class="consultas-link">
                Consultas Agendadas
            </a>

            <h3>Clique no médico para realizar um agendamento.</h3>
            
            <div class="medicos-container">
                <cfoutput query="listarMedicos">
                    <div class="medico-card">
                        <a href="agendamento.cfm?id_medico=#listarMedicos.id_medico#">
                            <img src="#listarMedicos.imagem#" alt="#listarMedicos.nome#">
                        </a>
                        <h3>#listarMedicos.nome#</h3>
                        <p>#listarMedicos.crm#</p>
                    </div>
                </cfoutput>
            </div>    
        </main>    
    </body>
</html>