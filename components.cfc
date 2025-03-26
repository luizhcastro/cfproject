<cfcomponent>
    <cfproperty name="projetoDB" type="string">
    <cfset this.projetoDB = "clinica">

    <cffunction name="getMedicos" returntype="Query">
    
        <cfquery datasource="#this.projetoDB#" name="qMedicos">
            SELECT * FROM medicos
        </cfquery>

        <cfreturn qMedicos>
    </cffunction>

    <cffunction name="getMedicoPorId" returntype="Query">
        <cfargument name="idMedico" required="false" default="0">

        <cfif ARGUMENTS.idMedico EQ 0>
            <cfquery datasource="#this.projetoDB#" name="qMedicoPorId">
                SELECT * FROM medicos
            </cfquery>
        <cfelse>
            <cfquery datasource="#this.projetoDB#" name="qMedicoPorId">
                SELECT * FROM medicos
                WHERE id_medico = <cfqueryparam value="#ARGUMENTS.idMedico#" cfsqltype="cf_sql_integer">
            </cfquery>
        </cfif>

        <cfreturn qMedicoPorId>
    </cffunction>

    <cffunction name="postNovoPaciente" returntype="String">
        <cfargument  name="cpf" required="true">
        <cfargument  name="nome" required="true">
        <cfargument  name="telefone" required="true">
        <cfargument  name="sexo" required="true">
        <cfargument  name="idade" required="true">
        <cfargument  name="endereco" required="true">
        
        <cfset erro=0>
        <cftry>
            <cfquery datasource="#this.projetoDB#">
                INSERT INTO pacientes
                    (cpf, nome, telefone, sexo, idade, endereco)
                VALUES
                    ('#ARGUMENTS.cpf#', '#ARGUMENTS.nome#', '#ARGUMENTS.telefone#',
                    '#ARGUMENTS.sexo#', #ARGUMENTS.idade#, '#ARGUMENTS.endereco#')
            </cfquery>
        <cfcatch type="any">
            <cfset erro=1>
        </cfcatch>
        </cftry>
        <cfif erro eq 0>
            <cfset msg="Agendamento realizado com sucesso!">
        <cfelse>
            <cfset msg="Ocorreu um erro durante o agendamento, tente novamente.">
        </cfif>
        <cfreturn msg>
    </cffunction>    

    <cffunction  name="getPacienteId" returntype="Query">
        <cfargument  name="cpf" required="true">
            <cfquery datasource="#this.projetoDB#" name="qRetornarIdPaciente">
                SELECT id_paciente FROM pacientes
                WHERE cpf = <cfqueryparam value="#ARGUMENTS.cpf#">
            </cfquery>
        <cfreturn qRetornarIdPaciente>
    </cffunction>

    <cffunction  name="postNovaConsulta" returntype="String">
        <cfargument  name="idPaciente" required="true">
        <cfargument  name="dataHora" required="true">
        <cfargument  name="idMedico" required="true">
        
        <cfset erro=0>
        <cftry>
            <cfquery datasource="#this.projetoDB#">
                INSERT INTO consultas
                    (id_medico, id_paciente, horario)
                VALUES
                    (#ARGUMENTS.idMedico#, #ARGUMENTS.idPaciente#, #ARGUMENTS.dataHora#)
            </cfquery>
        <cfcatch type="any">
            <cfset erro=1>
        </cfcatch>
        </cftry>
        <cfif erro eq 0>
            <cfset msg="Agendamento realizado com sucesso!">
        <cfelse>
            <cfset msg="Ocorreu um erro durante o agendamento, tente novamente.">
        </cfif>
        <cfreturn msg>
    </cffunction>

    <cffunction name="realizarFluxoCompletoDeAgendarNovaConsulta" returntype="String">
        <cfargument  name="cpf" required="true">
        <cfargument  name="nome" required="true">
        <cfargument  name="telefone" required="true">
        <cfargument  name="sexo" required="true">
        <cfargument  name="idade" required="true">
        <cfargument  name="endereco" required="true">
        <cfargument  name="idMedico" required="true">
        <cfargument  name="dataHoraConsulta" required="true">

        <cfinvoke method="postNovoPaciente" returnvariable="msg">
            <cfinvokeargument  name="cpf"  value="#ARGUMENTS.cpf#">
            <cfinvokeargument  name="nome"  value="#ARGUMENTS.nome#">
            <cfinvokeargument  name="telefone"  value="#ARGUMENTS.telefone#">
            <cfinvokeargument  name="sexo"  value="#ARGUMENTS.sexo#">
            <cfinvokeargument  name="idade"  value="#ARGUMENTS.idade#">
            <cfinvokeargument  name="endereco"  value="#ARGUMENTS.endereco#">
        </cfinvoke>

        <cfinvoke  method="getPacienteId" returnvariable="idPaciente">
            <cfinvokeargument  name="cpf"  value="#ARGUMENTS.cpf#">
        </cfinvoke>

        <cfset pacienteID = idPaciente.id_paciente>

        <cfinvoke method="postNovaConsulta" returnvariable="msg">
            <cfinvokeargument  name="idPaciente"  value="#pacienteID#">
            <cfinvokeargument  name="dataHora"  value="#ARGUMENTS.dataHoraConsulta#">
            <cfinvokeargument  name="idMedico"  value="#ARGUMENTS.idMedico#">
        </cfinvoke>

        <cfreturn msg>
    </cffunction>


    <cffunction name="getConsultas" returntype="Query">
        <cfquery datasource="#this.projetoDB#" name="qConsultas"> 
            SELECT * FROM consultas
        </cfquery>

        <cfreturn qConsultas>
    </cffunction>
</cfcomponent>