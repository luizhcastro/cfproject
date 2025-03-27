<cfset setLocale("pt_BR")>

<cfif isDefined("url.action")>
    <cfswitch expression="#url.action#">
        <cfcase value="search">
            <cfinvoke component="med_project.components" method="searchConsultas" returnvariable="listarConsultas">
                <cfinvokeargument name="searchTerm" value="#form.searchTerm#">
            </cfinvoke>
        </cfcase>
        
        <cfcase value="edit">
            <cfif isDefined("form.enviar_edicao")>
                <cfset dataHoraConsulta = createDateTime(
                    year(form.data_consulta_edicao), 
                    month(form.data_consulta_edicao), 
                    day(form.data_consulta_edicao), 
                    listFirst(form.hora_consulta_edicao, ':'), 
                    listLast(form.hora_consulta_edicao, ':'), 
                    0
                )>
                
                <cfinvoke component="med_project.components" method="updateConsulta" returnvariable="msg">
                    <cfinvokeargument name="idConsulta" value="#form.id_consulta#">
                    <cfinvokeargument name="idMedico" value="#form.id_medico_edicao#">
                    <cfinvokeargument name="dataHora" value="#dataHoraConsulta#">
                </cfinvoke>
            </cfif>
        </cfcase>
        
        <cfcase value="delete">
            <cfinvoke component="med_project.components" method="deleteConsulta" returnvariable="msg">
                <cfinvokeargument name="idConsulta" value="#url.id#">
            </cfinvoke>
        </cfcase>
    </cfswitch>
<cfelse>
    <cfinvoke component="med_project.components" method="getConsultas" returnvariable="listarConsultas" />
</cfif>

<cfinvoke component="med_project.components" method="getPacientes" returnvariable="listarPacientes" />
<cfinvoke component="med_project.components" method="getMedicos" returnvariable="listarMedicos" />

<cfset mapaPacientes = structNew()>
<cfloop query="listarPacientes">
    <cfset mapaPacientes[ listarPacientes.id_paciente ] = {
        nome = listarPacientes.nome,
        cpf = listarPacientes.cpf,
        telefone = listarPacientes.telefone
    }>
</cfloop>

<cfset mapaMedicos = structNew()>
<cfloop query="listarMedicos">
    <cfset mapaMedicos[ listarMedicos.id_medico ] = {
        nome = listarMedicos.nome,
        crm = listarMedicos.crm
    }>
</cfloop>

<!DOCTYPE html>
<html lang="pt">
    <head>
        <title>DBC Saúde - Consultas Agendadas</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="_css/styles.css">
    </head>
    <body>
        <div class="bg-gradient"></div>
        <div class="bg-pattern"></div>
        <div class="bg-blob bg-blob-1"></div>
        <div class="bg-blob bg-blob-2"></div>
        
        <header class="header">
            <div class="container">
                <div class="header-container">
                    <a href="homepage.cfm" class="logo">
                        <div class="logo-icon">
                            <i class="fas fa-heartbeat"></i>
                        </div>
                        DBC Saúde
                    </a>
                    <nav class="nav-links">
                        <a href="homepage.cfm" class="nav-link">
                            <i class="fas fa-home nav-link-icon"></i>
                            Início
                        </a>
                        <a href="consultas_agendadas.cfm" class="nav-link">
                            <i class="fas fa-calendar-check nav-link-icon"></i>
                            Consultas
                        </a>
                    </nav>
                </div>
            </div>
        </header>
        
        <main>
            <div class="container">
                <h1 class="animate-fadeIn">
                    Consultas <span class="highlight">Agendadas</span>
                </h1>
                
                <div class="consultas-container animate-fadeIn animate-delay-100">
                    <div class="consultas-header">
                        <h3 class="consultas-title">
                            <div class="consultas-title-icon">
                                <i class="fas fa-calendar-check"></i>
                            </div>
                            Agenda de Consultas
                        </h3>
                        <div class="consultas-actions">
                            <a href="homepage.cfm" class="btn btn-primary">
                                <i class="fas fa-plus"></i>
                                Nova Consulta
                            </a>
                        </div>
                    </div>
                    
                    <div class="consultas-body">
                        <!--- Formulário de busca --->
                        <form action="consultas_agendadas.cfm?action=search" method="post" class="mb-5">
                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label" for="searchTerm">Buscar Consultas</label>
                                    <i class="fas fa-search form-input-icon"></i>
                                    <input type="text" id="searchTerm" name="searchTerm" class="form-input" 
                                        placeholder="Buscar por médico, paciente, CPF, CRM ou data">
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary" style="margin-top: 1.8rem;">
                                        <i class="fas fa-search"></i> Buscar
                                    </button>
                                    <a href="consultas_agendadas.cfm" class="btn btn-outline" style="margin-top: 1.8rem;">
                                        <i class="fas fa-sync-alt"></i> Limpar
                                    </a>
                                </div>
                            </div>
                        </form>

                        <!--- Mensagens de feedback --->
                        <cfif isDefined("variables.msg")>
                            <div class="message <cfif findNoCase('sucesso', msg)>success<cfelse>error</cfif>">
                                <div class="message-icon">
                                    <i class="<cfif findNoCase('sucesso', msg)>fas fa-check-circle<cfelse>fas fa-exclamation-circle</cfif>"></i>
                                </div>
                                <div class="message-content">
                                    <h4 class="message-title">
                                        <cfif findNoCase('sucesso', msg)>Sucesso<cfelse>Erro</cfif>
                                    </h4>
                                    <p class="message-text">
                                        <cfoutput>#msg#</cfoutput>
                                    </p>
                                </div>
                            </div>
                        </cfif>

                        <table class="consultas-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Profissional</th>
                                    <th>Paciente</th>
                                    <th>Data e Hora</th>
                                    <th>Status</th>
                                    <th>Ações</th>
                                </tr>
                            </thead>
                            <tbody>
                                <cfloop query="listarConsultas">
                                    <cfset dadosMedico = mapaMedicos[ listarConsultas.id_medico ]>
                                    <cfset dadosPaciente = mapaPacientes[ listarConsultas.id_paciente ]>
                                    <cfoutput>
                                        <tr>
                                            <td>#listarConsultas.id_consulta#</td>
                                            <td>
                                                <strong>#dadosMedico.nome#</strong><br>
                                                CRM: #dadosMedico.crm#
                                            </td>
                                            <td>
                                                <strong>#dadosPaciente.nome#</strong><br>
                                                CPF: #dadosPaciente.cpf#<br>
                                                Tel: #dadosPaciente.telefone#
                                            </td>
                                            <td>
                                                #dateFormat(listarConsultas.horario, "dd/mm/yyyy")# às #timeFormat(listarConsultas.horario, "HH:nn")#
                                            </td>
                                            <td>
                                                <span class="status-badge status-agendada" title="Consulta agendada">
                                                    ✅ Agendada
                                                </span>
                                            </td>
                                            <td>
                                                <div class="flex gap-sm">
                                                    <!--- Botão Editar --->
                                                    <button type="button" class="btn btn-sm btn-outline" 
                                                            onclick="openEditModal(#listarConsultas.id_consulta#, #listarConsultas.id_medico#, '#dateFormat(listarConsultas.horario, "yyyy-mm-dd")#', '#timeFormat(listarConsultas.horario, "HH:mm")#')">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    
                                                    <!--- Botão Excluir --->
                                                    <a href="consultas_agendadas.cfm?action=delete&id=#listarConsultas.id_consulta#" 
                                                    class="btn btn-sm btn-outline" 
                                                    onclick="return confirm('Tem certeza que deseja excluir esta consulta?')">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </cfoutput>
                                </cfloop>
                            </tbody>
                        </table>
                    </div>

                    <!--- Modal de Edição --->
                    <div id="editModal" class="modal hidden">
                        <div class="modal-content">
                            <span class="close-modal" onclick="closeEditModal()">&times;</span>
                            <h3>Editar Consulta</h3>
                            
                            <form action="consultas_agendadas.cfm?action=edit" method="post">
                                <input type="hidden" name="id_consulta" id="edit_id_consulta">
                                
                                <div class="form-group">
                                    <label class="form-label" for="id_medico_edicao">Médico</label>
                                    <select id="id_medico_edicao" name="id_medico_edicao" class="form-input form-select" required>
                                        <option value="">Selecione o médico</option>
                                        <cfoutput query="listarMedicos">
                                            <option value="#listarMedicos.id_medico#">Dr. #listarMedicos.nome# - #listarMedicos.crm#</option>
                                        </cfoutput>
                                    </select>
                                </div>
                                
                                <div class="form-row">
                                    <div class="form-group">
                                        <label class="form-label" for="data_consulta_edicao">Data da Consulta</label>
                                        <input type="date" id="data_consulta_edicao" name="data_consulta_edicao" class="form-input"
                                            required min="#dateFormat(now(), 'yyyy-mm-dd')#">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label class="form-label" for="hora_consulta_edicao">Horário</label>
                                        <input type="time" id="hora_consulta_edicao" name="hora_consulta_edicao" class="form-input"
                                            required min="08:00" max="18:00" step="1800">
                                    </div>
                                </div>
                                
                                <div class="form-footer">
                                    <button type="submit" name="enviar_edicao" class="btn btn-primary">
                                        <i class="fas fa-save"></i> Salvar Alterações
                                    </button>
                                    <button type="button" class="btn btn-outline" onclick="closeEditModal()">
                                        Cancelar
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <script>
                        // Funções para o modal de edição
                        function openEditModal(idConsulta, idMedico, dataConsulta, horaConsulta) {
                            document.getElementById('edit_id_consulta').value = idConsulta;
                            document.getElementById('id_medico_edicao').value = idMedico;
                            document.getElementById('data_consulta_edicao').value = dataConsulta;
                            document.getElementById('hora_consulta_edicao').value = horaConsulta;
                            document.getElementById('editModal').classList.remove('hidden');
                        }
                        
                        function closeEditModal() {
                            document.getElementById('editModal').classList.add('hidden');
                        }
                        
                        // Fechar modal ao clicar fora
                        window.onclick = function(event) {
                            const modal = document.getElementById('editModal');
                            if (event.target === modal) {
                                closeEditModal();
                            }
                        }
                    </script>

                    <style>
                        /* Estilos para o modal */
                        .modal {
                            display: flex;
                            position: fixed;
                            z-index: var(--z-modal);
                            left: 0;
                            top: 0;
                            width: 100%;
                            height: 100%;
                            background-color: rgba(0, 0, 0, 0.5);
                            align-items: center;
                            justify-content: center;
                        }
                        
                        .modal-content {
                            background-color: white;
                            padding: var(--spacing-xl);
                            border-radius: var(--radius-lg);
                            width: 100%;
                            max-width: 600px;
                            box-shadow: var(--shadow-xl);
                            position: relative;
                        }
                        
                        .close-modal {
                            position: absolute;
                            top: var(--spacing-md);
                            right: var(--spacing-md);
                            font-size: 1.5rem;
                            cursor: pointer;
                            color: var(--text-tertiary);
                        }
                        
                        .close-modal:hover {
                            color: var(--text-primary);
                        }
                        
                        .hidden {
                            display: none;
                        }
                    </style>
                    </div>
                </div>
            </div>
        </main>
        
        <footer class="footer">
            <div class="container">
                <div class="footer-container">
                    <div class="footer-brand">
                        <a href="index.cfm" class="footer-logo">
                            <div class="footer-logo-icon">
                                <i class="fas fa-heartbeat"></i>
                            </div>
                            DBC Saúde
                        </a>
                        <p class="footer-description">
                            Cuidando da sua saúde com excelência e dedicação. Nossa missão é proporcionar atendimento médico de qualidade com tecnologia avançada e profissionais altamente qualificados.
                        </p>
                        <div class="footer-social">
                            <a href="#" class="footer-social-link">
                                <i class="fab fa-facebook-f"></i>
                            </a>
                            <a href="#" class="footer-social-link">
                                <i class="fab fa-instagram"></i>
                            </a>
                            <a href="#" class="footer-social-link">
                                <i class="fab fa-linkedin-in"></i>
                            </a>
                            <a href="#" class="footer-social-link">
                                <i class="fab fa-youtube"></i>
                            </a>
                        </div>
                    </div>
                    
                    <div class="footer-links-container">
                        <h4 class="footer-heading">Links Rápidos</h4>
                        <ul class="footer-links">
                            <li>
                                <a href="index.cfm" class="footer-link">
                                    <i class="fas fa-chevron-right footer-link-icon"></i>
                                    Início
                                </a>
                            </li>
                            <li>
                                <a href="consultas_agendadas.cfm" class="footer-link">
                                    <i class="fas fa-chevron-right footer-link-icon"></i>
                                    Consultas Agendadas
                                </a>
                            </li>
                            <li>
                                <a href="#" class="footer-link">
                                    <i class="fas fa-chevron-right footer-link-icon"></i>
                                    Sobre Nós
                                </a>
                            </li>
                            <li>
                                <a href="#" class="footer-link">
                                    <i class="fas fa-chevron-right footer-link-icon"></i>
                                    Especialidades
                                </a>
                            </li>
                        </ul>
                    </div>
                    
                    <div class="footer-contact-container">
                        <h4 class="footer-heading">Contato</h4>
                        <div class="footer-contact-item">
                            <div class="footer-contact-icon">
                                <i class="fas fa-map-marker-alt"></i>
                            </div>
                            <div class="footer-contact-content">
                                <div class="footer-contact-label">Endereço</div>
                                <div class="footer-contact-value">Av. Paulista, 1000 - São Paulo, SP</div>
                            </div>
                        </div>
                        <div class="footer-contact-item">
                            <div class="footer-contact-icon">
                                <i class="fas fa-phone-alt"></i>
                            </div>
                            <div class="footer-contact-content">
                                <div class="footer-contact-label">Telefone</div>
                                <div class="footer-contact-value">(11) 3000-0000</div>
                            </div>
                        </div>
                        <div class="footer-contact-item">
                            <div class="footer-contact-icon">
                                <i class="fas fa-envelope"></i>
                            </div>
                            <div class="footer-contact-content">
                                <div class="footer-contact-label">E-mail</div>
                                <div class="footer-contact-value">contato@dbcsaude.com.br</div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="footer-bottom">
                    <p>&copy; <script>document.write(new Date().getFullYear())</script> DBC Saúde. Todos os direitos reservados.</p>
                </div>
            </div>
        </footer>
    </body>
</html>