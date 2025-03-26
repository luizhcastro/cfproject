<cfset setLocale("pt_BR")>

<cfinvoke component="med_project.components" method="getConsultas" returnvariable="listarConsultas">
<cfinvoke component="med_project.components" method="getPacientes" returnvariable="listarPacientes">
<cfinvoke component="med_project.components" method="getMedicos" returnvariable="listarMedicos">

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
                        <table class="consultas-table">
                            <thead>
                                <tr>
                                    <th>
                                        <div class="flex items-center gap-sm">
                                            <div class="consultas-table-icon">
                                                <i class="fas fa-hashtag"></i>
                                            </div>
                                            ID
                                        </div>
                                    </th>
                                    <th>
                                        <div class="flex items-center gap-sm">
                                            <div class="consultas-table-icon">
                                                <i class="fas fa-hashtag"></i>
                                            </div>
                                            Prossifional
                                        </div>
                                    </th>
                                    <th>
                                        <div class="flex items-center gap-sm">
                                            <div class="consultas-table-icon">
                                                <i class="fas fa-hashtag"></i>
                                            </div>
                                            Paciente
                                        </div>
                                    </th>
                                    <th>
                                        <div class="flex items-center gap-sm">
                                            <div class="consultas-table-icon">
                                                <i class="fas fa-calendar-alt"></i>
                                            </div>
                                            Data e Hora
                                        </div>
                                    </th>
                                    <th>
                                        <div class="flex items-center gap-sm">
                                            <div class="consultas-table-icon">
                                                <i class="fas fa-info-circle"></i>
                                            </div>
                                            Status
                                        </div>
                                    </th>
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
                                        </tr>
                                    </cfoutput>
                                </cfloop>
                            </tbody>
                        </table>
                        
                        <div class="consultas-pagination">
                            <div class="consultas-pagination-item active">1</div>
                            <div class="consultas-pagination-item">2</div>
                            <div class="consultas-pagination-item">3</div>
                            <div class="consultas-pagination-item">
                                <i class="fas fa-chevron-right"></i>
                            </div>
                        </div>
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