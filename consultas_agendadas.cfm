<cfset setLocale("pt_BR")>

<cfinvoke component="med_project.components" method="getConsultas" returnvariable="listarConsultas">

<html lang="pt">
    <head>
        <title>DBC Saúde</title>
        <meta charset="utf-8">
    </head>
    <body>
        <main>
            <h1>
                DBC Saúde
            </h1>
                <h2>Consultas agendadas</h2>
            </a>
                <cfoutput query="listarConsultas">
                    <ul>
                        <li><#listarConsultas.id_consulta#</li>
                        <li>#listarConsultas.horario#</li>
                    </ul>
                </cfoutput>
            </div>    
        </main>    
    </body>
</html>