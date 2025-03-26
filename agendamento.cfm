<cfset setLocale("pt_BR")>

<cfset id = isDefined("url.id_medico") ? url.id_medico : 0>

<cfinvoke component="med_project.components" method="getMedicoPorId" returnvariable="listarMedicoPorId">
    <cfinvokeargument  name="idMedico"  value="#id#">
</cfinvoke>

<cfif isDefined("form.enviar")>
    <cfif structKeyExists(form, "data_consulta") AND structKeyExists(form, "hora_consulta")>
        <cfset dataHoraConsulta = createDateTime(year(form.data_consulta), 
                    month(form.data_consulta), 
                    day(form.data_consulta), 
                    listFirst(form.hora_consulta, ':'), 
                    listLast(form.hora_consulta, ':'), 0)>
    </cfif>

    <cfinvoke  component="med_project.components" method="realizarFluxoCompletoDeAgendarNovaConsulta" returnvariable="msg">
        <cfinvokeargument  name="cpf"  value="#form.cpf#">
        <cfinvokeargument  name="nome"  value="#form.nome#">
        <cfinvokeargument  name="telefone"  value="#form.telefone#">
        <cfinvokeargument  name="sexo"  value="#form.sexo#">
        <cfinvokeargument  name="idade"  value="#form.idade#">
        <cfinvokeargument  name="endereco"  value="#form.endereco#">
        <cfinvokeargument  name="idMedico"  value="#id#">
        <cfinvokeargument  name="dataHoraConsulta"  value="#dataHoraConsulta#">
    </cfinvoke>
</cfif>

<html lang="pt">
    <head>
        <title>DBC Saúde - Agendamento</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="_css/styles_agendamento.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Montserrat:wght@600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <main>
            <a href="homepage.cfm">
                <h1>DBC Saúde</h1>
            </a>
            <h2>Agendamento</h2>
            
            <cfoutput query="listarMedicoPorId">
                <div class="medico-info">
                    <h3>Dr. #listarMedicoPorId.nome#</h3>
                    <p>CRM: #listarMedicoPorId.crm#</p>
                </div>
            </cfoutput>

            <form action="agendamento.cfm?id_medico=<cfoutput>#id#</cfoutput>" method="post">
            
                <cfif isDefined("variables.msg")>
                    <div class="message <cfif findNoCase('sucesso', variables.msg)>success<cfelse>error</cfif>">
                        <cfoutput>#msg#</cfoutput>
                    </div>
                </cfif>

                <input type="hidden" name="id_medico" value="<cfoutput>#id#</cfoutput>">
                
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" maxlength="50" required>
                
                <label for="cpf">CPF (somente números):</label>
                <input type="text" id="cpf" name="cpf" maxlength="11" 
                       required pattern="\d{11}" 
                       title="CPF deve conter 11 dígitos numéricos">

                <label for="sexo">Sexo:</label>
                <select id="sexo" name="sexo" required>
                    <option value="">Selecione</option>
                    <option value="F">Feminino</option>
                    <option value="M">Masculino</option>
                </select>
            
                <label for="telefone">Telefone (somente números):</label>
                <input type="text" id="telefone" name="telefone" maxlength="11" 
                       required pattern="\d{11}" 
                       title="Telefone deve conter 11 dígitos numéricos">
            
                <label for="idade">Idade:</label>
                <input type="number" id="idade" name="idade" min="0" max="120" required>
            
                <label for="endereco">Endereço:</label>
                <input type="text" id="endereco" name="endereco" maxlength="200" required>

                <label for="data_consulta">Data da Consulta:</label>
                <input type="date" id="data_consulta" name="data_consulta" 
                       required 
                       min="<cfoutput>#dateFormat(now(), 'yyyy-mm-dd')#</cfoutput>"
                       title="Selecione uma data futura">

                <label for="hora_consulta">Horário da Consulta:</label>
                <input type="time" id="hora_consulta" name="hora_consulta" 
                       required 
                       min="08:00" max="18:00"
                       title="Horário entre 08:00 e 18:00">
        
                <input type="submit" name="enviar" value="Agendar Consulta">
            </form>
        </main>    
    </body>
</html>