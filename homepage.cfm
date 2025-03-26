<cfset setLocale("pt_BR")>

<cfinvoke component="med_project.components" method="getMedicos" returnvariable="listarMedicos">

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
            <a href="consultas_agendadas.cfm">
                <h2>Consultas agendadas</h2>
            </a>
            <h3>
                Clique no médico para realizar um agendamento.
            </h3>
                <cfoutput query="listarMedicos">
                    <ul>
                        <li class="imagem">
                            <a href="agendamento.cfm?id_medico=#listarMedicos.id_medico#">
                                <img src="#listarMedicos.imagem#" alt="#listarMedicos.nome#">
                            </a>
                        </li>
                        <li><h3>#listarMedicos.nome#</h3></li>
                        <li>#listarMedicos.crm#</li>
                    </ul>
                </cfoutput>
            </div>    
        </main>    
    </body>
</html>