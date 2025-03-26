<cfset setLocale("pt_BR")>

<cfinvoke component="med_project.components" method="getMedicos" returnvariable="listarMedicos">

<!DOCTYPE html>
<html lang="pt">
    <head>
        <title>DBC Saúde - Clínica Médica de Excelência</title>
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
                <section class="hero">
                    <div class="hero-content">
                        <div class="hero-badge animate-fadeIn">
                            <i class="fas fa-star"></i>
                            Clínica de Excelência
                        </div>
                        
                        <h1 class="hero-title animate-fadeIn animate-delay-100">
                            Cuidando da sua <span class="highlight">saúde</span> com excelência e dedicação
                        </h1>
                        
                        <p class="hero-subtitle animate-fadeIn animate-delay-200">
                            Na DBC Saúde, oferecemos atendimento médico personalizado com profissionais altamente qualificados, tecnologia de ponta e um ambiente acolhedor para cuidar do seu bem-estar.
                        </p>
                        
                        <div class="hero-actions animate-fadeIn animate-delay-300">
                            <a href="#medicos" class="btn btn-primary btn-lg animate-pulse">
                                <i class="fas fa-user-md"></i>
                                Agendar Consulta
                            </a>
                            <a href="consultas_agendadas.cfm" class="btn btn-outline btn-lg">
                                <i class="fas fa-calendar-check"></i>
                                Ver Minhas Consultas
                            </a>
                        </div>
                        
                        <div class="hero-stats animate-fadeIn animate-delay-400">
                            <div class="hero-stat">
                                <div class="hero-stat-value">15+</div>
                                <div class="hero-stat-label">Especialidades</div>
                            </div>
                            <div class="hero-stat">
                                <div class="hero-stat-value">30+</div>
                                <div class="hero-stat-label">Médicos</div>
                            </div>
                            <div class="hero-stat">
                                <div class="hero-stat-value">10k+</div>
                                <div class="hero-stat-label">Pacientes Atendidos</div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <section id="medicos" class="animate-fadeIn">
                    <div class="section-header">
                        <h2 class="section-title">Nossa Equipe Médica Especializada</h2>
                        <p class="section-subtitle">
                            Conheça nossos profissionais altamente qualificados e escolha o especialista ideal para cuidar da sua saúde
                        </p>
                    </div>
                    
                    <div class="medicos-grid">
                        <cfoutput query="listarMedicos">
                            <div class="medico-card animate-fadeIn">
                                <div class="medico-card-image">
                                    <img src="#listarMedicos.imagem#" alt="Dr. #listarMedicos.nome#">
                                    <div class="medico-card-overlay"></div>
                                </div>
                                <div class="medico-card-content">
                                    <h3 class="medico-card-title">Dr. #listarMedicos.nome#</h3>
                                    <div class="medico-card-subtitle">
                                        <i class="fas fa-id-card"></i>
                                        #listarMedicos.crm#
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
                                    
                                    <div class="medico-card-footer">
                                        <a href="agendamento.cfm?id_medico=#listarMedicos.id_medico#" class="medico-card-action">
                                            <i class="fas fa-calendar-plus"></i>
                                            Agendar
                                        </a>
                                        
                                        <div class="medico-card-rating">
                                            <span class="medico-card-rating-stars">
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star-half-alt"></i>
                                            </span>
                                            4.8
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </cfoutput>
                    </div>
                </section>
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