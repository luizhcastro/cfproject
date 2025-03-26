<cfset setLocale("pt_BR")>

<cfset id = isDefined("url.id_medico") ? url.id_medico : 0>

<cfinvoke component="med_project.components" method="getMedicoPorId" returnvariable="listarMedicoPorId">
    <cfinvokeargument name="idMedico" value="#id#">
</cfinvoke>

<cfif isDefined("form.enviar")>
    <cfif structKeyExists(form, "data_consulta") AND structKeyExists(form, "hora_consulta")>
        <cfset dataHoraConsulta = createDateTime(year(form.data_consulta), 
                    month(form.data_consulta), 
                    day(form.data_consulta), 
                    listFirst(form.hora_consulta, ':'), 
                    listLast(form.hora_consulta, ':'), 0)>
    </cfif>

    <cfinvoke component="med_project.components" method="realizarFluxoCompletoDeAgendarNovaConsulta" returnvariable="msg">
        <cfinvokeargument name="cpf" value="#form.cpf#">
        <cfinvokeargument name="nome" value="#form.nome#">
        <cfinvokeargument name="telefone" value="#form.telefone#">
        <cfinvokeargument name="sexo" value="#form.sexo#">
        <cfinvokeargument name="idade" value="#form.idade#">
        <cfinvokeargument name="endereco" value="#form.endereco#">
        <cfinvokeargument name="idMedico" value="#id#">
        <cfinvokeargument name="dataHoraConsulta" value="#dataHoraConsulta#">
    </cfinvoke>
</cfif>

<!DOCTYPE html>
<html lang="pt">
    <head>
        <title>DBC Saúde - Agendamento de Consulta</title>
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
                    Agendamento de <span class="highlight">Consulta</span>
                </h1>
                
                <cfoutput query="listarMedicoPorId">
                    <div class="medico-card animate-fadeIn animate-delay-100">
                        <div class="medico-card-content">
                            <h3 class="medico-card-title">
                                <i class="fas fa-user-md"></i> 
                                Médico: Dr. #listarMedicoPorId.nome#
                            </h3>
                            <div class="medico-card-subtitle">
                                <i class="fas fa-id-card"></i>
                                #listarMedicoPorId.crm#
                            </div>
                            
                            <div class="medico-card-badges">
                                <span class="medico-card-badge">
                                    <i class="fas fa-stethoscope"></i>
                                    Clínico Geral
                                </span>
                                <span class="medico-card-badge secondary">
                                    <i class="fas fa-user-md"></i>
                                    Especialista
                                </span>
                            </div>
                        </div>
                    </div>
                </cfoutput>

                <cfif isDefined("variables.msg")>
                    <div class="message <cfif findNoCase('sucesso', msg)>success<cfelse>error</cfif> animate-fadeIn animate-delay-200">
                        <div class="message-icon">
                            <i class="<cfif findNoCase('sucesso', msg)>fas fa-check-circle<cfelse>fas fa-exclamation-circle</cfif>"></i>
                        </div>
                        <div class="message-content">
                            <h4 class="message-title">
                                <cfif findNoCase('sucesso', msg)>Agendamento Realizado<cfelse>Erro no Agendamento</cfif>
                            </h4>
                            <p class="message-text">
                                <cfoutput>#msg#</cfoutput>
                            </p>
                        </div>
                    </div>
                </cfif>
                
                <div class="form-container animate-fadeIn animate-delay-300">
                    <div class="form-header">
                        <h3 class="form-title">Agende sua Consulta</h3>
                        <p class="form-subtitle">Preencha o formulário abaixo com seus dados para agendar sua consulta</p>
                    </div>
                    
                    <form action="agendamento.cfm?id_medico=<cfoutput>#id#</cfoutput>" method="post">
                        <div class="form-body">
                            <input type="hidden" name="id_medico" value="<cfoutput>#id#</cfoutput>">
                            
                            <div class="form-section">
                                <h4 class="form-section-title">
                                    <div class="form-section-icon">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    Dados Pessoais
                                </h4>
                                
                                <div class="form-row">
                                    <div class="form-group">
                                        <label class="form-label" for="nome">Nome Completo</label>
                                        <i class="fas fa-user form-input-icon"></i>
                                        <input type="text" id="nome" name="nome" class="form-input" maxlength="50" required placeholder="Digite seu nome completo">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label class="form-label" for="cpf">CPF (somente números)</label>
                                        <i class="fas fa-id-card form-input-icon"></i>
                                        <input type="text" id="cpf" name="cpf" class="form-input" maxlength="11" 
                                               required pattern="\d{11}" 
                                               placeholder="00000000000"
                                               title="CPF deve conter 11 dígitos numéricos">
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group">
                                        <label class="form-label" for="sexo">Sexo</label>
                                        <i class="fas fa-venus-mars form-input-icon"></i>
                                        <select id="sexo" name="sexo" class="form-input form-select" required>
                                            <option value="">Selecione</option>
                                            <option value="F">Feminino</option>
                                            <option value="M">Masculino</option>
                                        </select>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label class="form-label" for="idade">Idade</label>
                                        <i class="fas fa-birthday-cake form-input-icon"></i>
                                        <input type="number" id="idade" name="idade" class="form-input" min="0" max="120" required placeholder="Digite sua idade">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-section">
                                <h4 class="form-section-title">
                                    <div class="form-section-icon">
                                        <i class="fas fa-phone-alt"></i>
                                    </div>
                                    Contato e Endereço
                                </h4>
                                
                                <div class="form-row">
                                    <div class="form-group">
                                        <label class="form-label" for="telefone">Telefone (somente números)</label>
                                        <i class="fas fa-phone form-input-icon"></i>
                                        <input type="text" id="telefone" name="telefone" class="form-input" maxlength="11" 
                                               required pattern="\d{11}" 
                                               placeholder="00000000000"
                                               title="Telefone deve conter 11 dígitos numéricos">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label class="form-label" for="endereco">Endereço Completo</label>
                                        <i class="fas fa-map-marker-alt form-input-icon"></i>
                                        <input type="text" id="endereco" name="endereco" class="form-input" maxlength="200" required placeholder="Digite seu endereço completo">
                                    </div>
                                </div>
                            </div>

                            <div class="form-section">
                                <h4 class="form-section-title">
                                    <div class="form-section-icon">
                                        <i class="fas fa-calendar-alt"></i>
                                    </div>
                                    Data e Horário
                                </h4>
                                
                                <div class="form-row">
                                    <div class="form-group">
                                        <label class="form-label" for="data_consulta">Data da Consulta</label>
                                        <i class="fas fa-calendar-alt form-input-icon"></i>
                                        <input type="date" id="data_consulta" name="data_consulta" class="form-input"
                                               required 
                                               min="<cfoutput>#dateFormat(now(), 'yyyy-mm-dd')#</cfoutput>"
                                               title="Selecione uma data futura">
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label" for="hora_consulta">Horário da Consulta</label>
                                        <i class="fas fa-clock form-input-icon"></i>
                                        <input type="time" 
                                            id="hora_consulta" 
                                            name="hora_consulta" 
                                            class="form-input"
                                            required 
                                            min="08:00" 
                                            max="18:00" 
                                            step="1800"
                                            title="Selecione um horário entre 08:00 e 18:00, de 30 em 30 minutos">
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-footer">
                            <button type="submit" name="enviar" class="form-submit">
                                <i class="fas fa-calendar-check"></i>
                                Confirmar Agendamento
                            </button>
                        </div>
                    </form>
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