<cfset setLocale("pt_BR")>

<cfinvoke component="med_project.components" method="getConsultas" returnvariable="listarConsultas">

<html lang="pt">
    <head>
        <title>DBC Saúde - Consultas Agendadas</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="_css/styles_consultas.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Montserrat:wght@600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <main> 
            <a href="homepage.cfm">
                <h1>DBC Saúde</h1>
            </a>
            <h2>Consultas Agendadas</h2>
            
            <div class="consultas-container">
                <cfoutput query="listarConsultas">
                    <div class="consulta-card">
                        <ul>
                            <li class="consulta-id">Consulta #id_consulta#</li>
                            <li class="consulta-horario">#horario#</li>
                        </ul>
                    </div>
                </cfoutput>
            </div>
        </main>    
    </body>
</html>