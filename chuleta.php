<?php
// chuleta.php — Referencia rápida de servicios AWS para el examen CLF-C02
// Los nombres de servicios siempre en inglés conforme a AWS oficial

$CATEGORIAS = [
  'compute' => [
    'label' => 'Computación',
    'color' => '#E65100',
    'bg'    => '#FFF3E0',
    'dot'   => '#FF9900',
    'icon'  => 'fa-server',
  ],
  'storage' => [
    'label' => 'Almacenamiento',
    'color' => '#2E7D32',
    'bg'    => '#E8F5E9',
    'dot'   => '#43A047',
    'icon'  => 'fa-hdd',
  ],
  'database' => [
    'label' => 'Bases de Datos',
    'color' => '#1565C0',
    'bg'    => '#E3F2FD',
    'dot'   => '#1E88E5',
    'icon'  => 'fa-database',
  ],
  'network' => [
    'label' => 'Redes & CDN',
    'color' => '#4A148C',
    'bg'    => '#F3E5F5',
    'dot'   => '#7B1FA2',
    'icon'  => 'fa-network-wired',
  ],
  'security' => [
    'label' => 'Seguridad & IAM',
    'color' => '#880E4F',
    'bg'    => '#FCE4EC',
    'dot'   => '#C2185B',
    'icon'  => 'fa-shield-alt',
  ],
  'mgmt' => [
    'label' => 'Gestión & Gobernanza',
    'color' => '#4527A0',
    'bg'    => '#EDE7F6',
    'dot'   => '#5E35B1',
    'icon'  => 'fa-cogs',
  ],
  'integration' => [
    'label' => 'Integración & Análisis',
    'color' => '#006064',
    'bg'    => '#E0F7FA',
    'dot'   => '#00897B',
    'icon'  => 'fa-project-diagram',
  ],
  'ml' => [
    'label' => 'Machine Learning & IA',
    'color' => '#1A237E',
    'bg'    => '#E8EAF6',
    'dot'   => '#3949AB',
    'icon'  => 'fa-brain',
  ],
  'fundamentals' => [
    'label' => 'Fundamentos & Arquitectura',
    'color' => '#4E342E',
    'bg'    => '#EFEBE9',
    'dot'   => '#6D4C41',
    'icon'  => 'fa-graduation-cap',
  ],
];

// icon => null  → usa texto con iniciales
// icon => URL   → img tag (Simple Icons CDN)
// icon => 'fa-*'→ Font Awesome icon

$SERVICIOS = [

  // ─── COMPUTACIÓN ───────────────────────────────────────────────────────────
  ['cat'=>'compute','prefix'=>'Amazon','name'=>'EC2',
   'full'=>'Amazon EC2',
   'icon_url'=>'https://cdn.simpleicons.org/amazonec2/E65100',
   'desc'=>'Instancias virtuales (servidores) en la nube. Totalmente configurables en SO, CPU, RAM y almacenamiento.',
   'facts'=>['On-Demand: pago por segundo/hora sin compromiso','Reserved: hasta 72% descuento con compromiso 1-3 años','Spot: hasta 90% descuento, pueden interrumpirse','AMI: plantilla para lanzar instancias'],
   'freq'=>3],

  ['cat'=>'compute','prefix'=>'AWS','name'=>'Lambda',
   'full'=>'AWS Lambda',
   'icon_url'=>'https://cdn.simpleicons.org/awslambda/E65100',
   'desc'=>'Cómputo serverless. Ejecuta código en respuesta a eventos sin gestionar servidores.',
   'facts'=>['Máx. 15 minutos de ejecución por invocación','Pago por número de invocaciones + duración (ms)','Escala automáticamente a millones de peticiones','Se integra con S3, DynamoDB, API Gateway, SQS…'],
   'freq'=>3],

  ['cat'=>'compute','prefix'=>'AWS','name'=>'Elastic Beanstalk',
   'full'=>'AWS Elastic Beanstalk',
   'icon_url'=>'https://cdn.simpleicons.org/amazonelasticbeanstalk/E65100',
   'desc'=>'PaaS para desplegar aplicaciones web sin gestionar la infraestructura subyacente (EC2, ELB, Auto Scaling).',
   'facts'=>['Soporta Java, Python, PHP, Node.js, Ruby, Go, Docker','Tú subes el código, AWS gestiona el resto','Puedes acceder a los recursos subyacentes si necesitas'],
   'freq'=>2],

  ['cat'=>'compute','prefix'=>'Amazon','name'=>'ECS',
   'full'=>'Amazon ECS',
   'icon_url'=>'https://cdn.simpleicons.org/amazonecs/E65100',
   'desc'=>'Orquestador de contenedores Docker gestionado por AWS. Puede usar instancias EC2 o Fargate (serverless).',
   'facts'=>['ECS en EC2: tú gestionas los servidores','ECS con Fargate: AWS gestiona los servidores','Integrado con IAM, ELB, CloudWatch, ECR'],
   'freq'=>2],

  ['cat'=>'compute','prefix'=>'Amazon','name'=>'EKS',
   'full'=>'Amazon EKS',
   'icon_url'=>'https://cdn.simpleicons.org/amazoneks/E65100',
   'desc'=>'Kubernetes gestionado por AWS. Ejecuta y escala aplicaciones en contenedores con Kubernetes estándar.',
   'facts'=>['Compatible 100% con Kubernetes upstream','Puede usar nodos EC2 o Fargate (serverless)','Ideal para equipos que ya usan Kubernetes'],
   'freq'=>2],

  ['cat'=>'compute','prefix'=>'AWS','name'=>'Fargate',
   'full'=>'AWS Fargate',
   'icon_url'=>'https://cdn.simpleicons.org/awsfargate/E65100',
   'desc'=>'Motor de cómputo serverless para contenedores (ECS y EKS). Sin gestión de servidores ni clústeres.',
   'facts'=>['Defines CPU y memoria por tarea/pod','AWS aprovisiona y escala la infraestructura','Pago por los recursos de cómputo usados'],
   'freq'=>2],

  ['cat'=>'compute','prefix'=>'Amazon','name'=>'Lightsail',
   'full'=>'Amazon Lightsail',
   'icon_url'=>null,'initials'=>'LS','init_color'=>'#E65100','init_bg'=>'#FFF3E0',
   'desc'=>'VPS (servidores privados virtuales) con precio fijo y predecible. Diseñado para proyectos simples.',
   'facts'=>['Incluye VM + almacenamiento + red + IP fija + DNS','Precio fijo mensual (desde ~3,50 USD)','Ideal para desarrolladores individuales y PYMEs'],
   'freq'=>2],

  ['cat'=>'compute','prefix'=>'AWS','name'=>'Batch',
   'full'=>'AWS Batch',
   'icon_url'=>null,'initials'=>'Batch','init_color'=>'#E65100','init_bg'=>'#FFF3E0',
   'desc'=>'Ejecuta trabajos de procesamiento batch a cualquier escala. Aprovisiona automáticamente el cómputo óptimo.',
   'facts'=>['Gestiona colas de trabajo y prioridades','Usa instancias EC2 On-Demand o Spot','Ideal para HPC, renderizado, simulaciones, análisis'],
   'freq'=>1],

  ['cat'=>'compute','prefix'=>'AWS','name'=>'Outposts',
   'full'=>'AWS Outposts',
   'icon_url'=>null,'initials'=>'OP','init_color'=>'#E65100','init_bg'=>'#FFF3E0',
   'desc'=>'Infraestructura y servicios AWS físicamente en tus instalaciones. Misma experiencia AWS on-premises.',
   'facts'=>['Rack de servidores AWS instalado en tu CPD','Latencia ultra-baja para datos locales','Útil para requisitos de residencia de datos'],
   'freq'=>1],

  ['cat'=>'compute','prefix'=>'Amazon','name'=>'AppStream 2.0',
   'full'=>'Amazon AppStream 2.0',
   'icon_url'=>null,'initials'=>'AS2','init_color'=>'#E65100','init_bg'=>'#FFF3E0',
   'desc'=>'Streaming de aplicaciones de escritorio a navegadores web sin instalar software en el dispositivo del usuario.',
   'facts'=>['Aplicaciones Windows en cualquier dispositivo','Los datos no se almacenan localmente','Útil para CAD, BI tools, aplicaciones corporativas'],
   'freq'=>1],

  ['cat'=>'compute','prefix'=>'Amazon','name'=>'WorkSpaces',
   'full'=>'Amazon WorkSpaces',
   'icon_url'=>null,'initials'=>'WS','init_color'=>'#E65100','init_bg'=>'#FFF3E0',
   'desc'=>'Escritorios virtuales (VDI) en la nube. Windows o Linux accesibles desde cualquier dispositivo.',
   'facts'=>['Servicio DaaS (Desktop as a Service)','Pago por uso o mensual','Persistencia de datos y personalización de entorno'],
   'freq'=>1],

  ['cat'=>'compute','prefix'=>'Amazon','name'=>'EC2 Auto Scaling',
   'full'=>'Amazon EC2 Auto Scaling',
   'icon_url'=>null,'initials'=>'AS','init_color'=>'#E65100','init_bg'=>'#FFF3E0',
   'desc'=>'Ajusta automáticamente el número de instancias EC2 según la demanda, garantizando disponibilidad y optimizando costos.',
   'facts'=>['Políticas: Target Tracking, Step Scaling, Scheduled','Min/Max/Desired: define los límites de capacidad','Health Checks: reemplaza instancias no saludables automáticamente','Integrado con ELB para distribución de carga'],
   'freq'=>3],

  ['cat'=>'compute','prefix'=>'EC2','name'=>'Tipos de Instancia',
   'full'=>'Familias de Instancias EC2',
   'icon_url'=>null,'initials'=>'T→X','init_color'=>'#E65100','init_bg'=>'#FFF3E0',
   'desc'=>'EC2 ofrece familias especializadas: General Purpose, Compute, Memory, Storage, Accelerated Computing y HPC.',
   'facts'=>['T (t3, t4g): uso general, burstable · M (m6i): uso general balanceado','C (c6g, c5): compute optimized · R (r6g): memory optimized','I (i3, i4i): storage optimized NVMe · X (x2idn): ultra memory','P/G/Inf: GPU/ML · Hpc: High Performance Computing'],
   'freq'=>2],

  ['cat'=>'compute','prefix'=>'EC2','name'=>'Modelos de Precios EC2',
   'full'=>'Modelos de Compra EC2',
   'icon_url'=>null,'initials'=>'$EC2','init_color'=>'#E65100','init_bg'=>'#FFF3E0',
   'desc'=>'Cinco modelos de compra para EC2 según necesidad: On-Demand, Reserved, Spot, Savings Plans y Dedicated.',
   'facts'=>['On-Demand: sin compromiso, precio por hora/segundo','Reserved 1-3 años: hasta 72% descuento (Standard/Convertible)','Spot: hasta 90% descuento, interrumpible con aviso de 2 min','Savings Plans: descuento por compromiso de $/hora (más flexible que Reserved)','Dedicated Host/Instance: hardware físico exclusivo (compliance)'],
   'freq'=>3],

  ['cat'=>'compute','prefix'=>'EC2','name'=>'Image Builder',
   'full'=>'EC2 Image Builder',
   'icon_url'=>null,'initials'=>'ImgB','init_color'=>'#E65100','init_bg'=>'#FFF3E0',
   'desc'=>'Automatiza la creación, prueba y distribución de AMIs (Amazon Machine Images) y imágenes de contenedor.',
   'facts'=>['Pipelines de imagen: define componentes, recetas y pruebas','Distribución multi-región y multi-cuenta automática','Integrado con Inspector para escaneo de vulnerabilidades','Reduce el esfuerzo de parcheo y mantenimiento de imágenes base'],
   'freq'=>1],

  // ─── ALMACENAMIENTO ────────────────────────────────────────────────────────
  ['cat'=>'storage','prefix'=>'Amazon','name'=>'S3',
   'full'=>'Amazon S3',
   'icon_url'=>'https://cdn.simpleicons.org/amazons3/2E7D32',
   'desc'=>'Almacenamiento de objetos escalable con durabilidad del 99.999999999% (11 nueves). El más usado en AWS.',
   'facts'=>['Clases: Standard, Intelligent-Tiering, Standard-IA, One Zone-IA, Glacier…','Objetos hasta 5 TB; bucket ilimitado','Versionado, Object Lock (WORM), Lifecycle Rules','CRR: replicación automática entre regiones'],
   'freq'=>3],

  ['cat'=>'storage','prefix'=>'Amazon','name'=>'EBS',
   'full'=>'Amazon EBS',
   'icon_url'=>null,'initials'=>'EBS','init_color'=>'#2E7D32','init_bg'=>'#E8F5E9',
   'desc'=>'Volúmenes de almacenamiento de bloque persistente para instancias EC2. Similar a un disco duro virtual.',
   'facts'=>['Persiste independientemente de la vida de la instancia','Se puede adjuntar a una instancia en la misma AZ','Tipos: gp3 (SSD general), io2 (IOPS provisioned), st1/sc1 (HDD)','Snapshots incrementales guardados en S3'],
   'freq'=>2],

  ['cat'=>'storage','prefix'=>'Amazon','name'=>'EFS',
   'full'=>'Amazon EFS',
   'icon_url'=>null,'initials'=>'EFS','init_color'=>'#2E7D32','init_bg'=>'#E8F5E9',
   'desc'=>'Sistema de archivos NFS compartido y elástico. Montado simultáneamente por miles de instancias EC2.',
   'facts'=>['Compatible con NFS v4.1 y v4.2','Escala automáticamente (sin provisionar capacidad)','Multi-AZ: accesible desde cualquier AZ de la región','EFS One Zone: versión de una sola AZ más económica'],
   'freq'=>2],

  ['cat'=>'storage','prefix'=>'Amazon','name'=>'FSx',
   'full'=>'Amazon FSx',
   'icon_url'=>null,'initials'=>'FSx','init_color'=>'#2E7D32','init_bg'=>'#E8F5E9',
   'desc'=>'Sistemas de archivos de terceros totalmente gestionados: Windows File Server, Lustre, NetApp ONTAP, OpenZFS.',
   'facts'=>['FSx for Windows: SMB, compatible con Active Directory','FSx for Lustre: HPC, ML, procesamiento de datos','Integrado con S3, backup automático, Multi-AZ'],
   'freq'=>1],

  ['cat'=>'storage','prefix'=>'Amazon','name'=>'S3 Glacier',
   'full'=>'Amazon S3 Glacier',
   'icon_url'=>null,'initials'=>'Glcr','init_color'=>'#2E7D32','init_bg'=>'#E8F5E9',
   'desc'=>'Almacenamiento de archivado de largo plazo a bajo costo. Tres variantes según velocidad de recuperación.',
   'facts'=>['Instant Retrieval: milisegundos','Flexible Retrieval: minutos a horas','Deep Archive: 12-48 horas (más barato de AWS)','Mínimo 90-180 días de almacenamiento'],
   'freq'=>2],

  ['cat'=>'storage','prefix'=>'AWS','name'=>'Storage Gateway',
   'full'=>'AWS Storage Gateway',
   'icon_url'=>null,'initials'=>'SG','init_color'=>'#2E7D32','init_bg'=>'#E8F5E9',
   'desc'=>'Conecta aplicaciones on-premises con almacenamiento en la nube AWS. Tres modos: File, Volume y Tape.',
   'facts'=>['File Gateway: archivos como objetos S3 (NFS/SMB)','Volume Gateway: volúmenes iSCSI respaldados en S3/EBS','Tape Gateway: reemplaza cintas físicas con S3 Glacier'],
   'freq'=>1],

  ['cat'=>'storage','prefix'=>'AWS','name'=>'Backup',
   'full'=>'AWS Backup',
   'icon_url'=>null,'initials'=>'BKP','init_color'=>'#2E7D32','init_bg'=>'#E8F5E9',
   'desc'=>'Servicio centralizado para automatizar y gestionar backups de múltiples servicios AWS.',
   'facts'=>['Soporta EC2, EBS, RDS, DynamoDB, EFS, S3, FSx','Políticas de backup centralizadas','Cumplimiento y auditoría de backups'],
   'freq'=>1],

  ['cat'=>'storage','prefix'=>'AWS','name'=>'Snowball',
   'full'=>'AWS Snowball',
   'icon_url'=>null,'initials'=>'Snow','init_color'=>'#2E7D32','init_bg'=>'#E8F5E9',
   'desc'=>'Dispositivo físico maleta para migrar grandes volúmenes de datos a AWS sin usar la red de internet.',
   'facts'=>['Snowball Edge: 80 TB, cómputo local integrado','Ideal para zonas sin conectividad o migración masiva','Snowmobile: camión para hasta 100 Exabytes'],
   'freq'=>2],

  ['cat'=>'storage','prefix'=>'AWS','name'=>'DataSync',
   'full'=>'AWS DataSync',
   'icon_url'=>null,'initials'=>'DS','init_color'=>'#2E7D32','init_bg'=>'#E8F5E9',
   'desc'=>'Transferencia automatizada y acelerada de datos entre almacenamiento on-premises y AWS.',
   'facts'=>['Hasta 10x más rápido que herramientas open source','NFS, SMB, HDFS, Amazon S3, EFS, FSx','Programación, filtrado y validación automáticos'],
   'freq'=>1],

  ['cat'=>'storage','prefix'=>'S3','name'=>'Transfer Acceleration',
   'full'=>'S3 Transfer Acceleration',
   'icon_url'=>null,'initials'=>'S3TA','init_color'=>'#2E7D32','init_bg'=>'#E8F5E9',
   'desc'=>'Acelera las subidas a S3 enrutando el tráfico a través de las Edge Locations de CloudFront.',
   'facts'=>['Usa la red backbone privada de AWS desde la Edge Location más cercana','Hasta 50-500% más rápido para subidas desde ubicaciones lejanas','Se habilita a nivel de bucket; URL específica (.s3-accelerate.amazonaws.com)','Coste adicional por GB transferido; ideal para uploads globales de gran tamaño'],
   'freq'=>2],

  // ─── BASES DE DATOS ────────────────────────────────────────────────────────
  ['cat'=>'database','prefix'=>'Amazon','name'=>'RDS',
   'full'=>'Amazon RDS',
   'icon_url'=>'https://cdn.simpleicons.org/amazonrds/1565C0',
   'desc'=>'Bases de datos relacionales gestionadas. Soporta MySQL, PostgreSQL, MariaDB, Oracle, SQL Server y Aurora.',
   'facts'=>['Multi-AZ: réplica sincrónica para HA','Read Replicas: réplicas de lectura (hasta 5)','Automated Backups: retención 1-35 días','No acceso al SO subyacente (es servicio gestionado)'],
   'freq'=>3],

  ['cat'=>'database','prefix'=>'Amazon','name'=>'Aurora',
   'full'=>'Amazon Aurora',
   'icon_url'=>null,'initials'=>'Aur','init_color'=>'#1565C0','init_bg'=>'#E3F2FD',
   'desc'=>'Base de datos relacional propia de AWS compatible con MySQL y PostgreSQL. Hasta 5x más rendimiento.',
   'facts'=>['Almacenamiento auto-escalable hasta 128 TiB','6 copias de datos en 3 AZs automáticamente','Aurora Serverless v2: escala a 0 cuando no hay actividad','Aurora Global: replicación entre regiones < 1 segundo'],
   'freq'=>2],

  ['cat'=>'database','prefix'=>'Amazon','name'=>'DynamoDB',
   'full'=>'Amazon DynamoDB',
   'icon_url'=>'https://cdn.simpleicons.org/amazondynamodb/1565C0',
   'desc'=>'Base de datos NoSQL de clave-valor y documentos. Latencia de milisegundos de un solo dígito a cualquier escala.',
   'facts'=>['Completamente serverless y gestionado','DynamoDB Accelerator (DAX): caché en memoria','Global Tables: replicación multi-región activa-activa','On-Demand o Provisioned capacity'],
   'freq'=>3],

  ['cat'=>'database','prefix'=>'Amazon','name'=>'Redshift',
   'full'=>'Amazon Redshift',
   'icon_url'=>'https://cdn.simpleicons.org/amazonredshift/1565C0',
   'desc'=>'Data warehouse en la nube completamente gestionado. Análisis de petabytes de datos con SQL estándar.',
   'facts'=>['Almacenamiento columnar para consultas analíticas rápidas','Redshift Spectrum: consultar datos directamente en S3','Integrado con BI tools (QuickSight, Tableau…)','Hasta 128 nodos en clúster'],
   'freq'=>2],

  ['cat'=>'database','prefix'=>'Amazon','name'=>'ElastiCache',
   'full'=>'Amazon ElastiCache',
   'icon_url'=>'https://cdn.simpleicons.org/amazonelasticache/1565C0',
   'desc'=>'Servicio de caché en memoria gestionado. Compatible con Redis y Memcached.',
   'facts'=>['Redis: persistencia, replicación, Pub/Sub, Lua','Memcached: multihilo, más simple','Reduce latencia de BD pasando de ms a µs','Útil para sesiones, rankings, tiempo real'],
   'freq'=>2],

  ['cat'=>'database','prefix'=>'Amazon','name'=>'Neptune',
   'full'=>'Amazon Neptune',
   'icon_url'=>null,'initials'=>'Npt','init_color'=>'#1565C0','init_bg'=>'#E3F2FD',
   'desc'=>'Base de datos de grafos completamente gestionada. Soporta Property Graph (Gremlin) y RDF (SPARQL).',
   'facts'=>['Redes sociales, detección de fraude, grafos de conocimiento','Alta disponibilidad con 6 copias en 3 AZs','Réplicas de lectura de baja latencia'],
   'freq'=>1],

  ['cat'=>'database','prefix'=>'Amazon','name'=>'DocumentDB',
   'full'=>'Amazon DocumentDB',
   'icon_url'=>null,'initials'=>'DocDB','init_color'=>'#1565C0','init_bg'=>'#E3F2FD',
   'desc'=>'Base de datos de documentos gestionada, compatible con MongoDB. Para datos JSON a escala.',
   'facts'=>['Compatible con drivers y herramientas de MongoDB','Alta disponibilidad: 6 copias en 3 AZs','Escala hasta 64 TiB de almacenamiento automáticamente'],
   'freq'=>1],

  ['cat'=>'database','prefix'=>'Amazon','name'=>'QLDB',
   'full'=>'Amazon QLDB',
   'icon_url'=>null,'initials'=>'QLDB','init_color'=>'#1565C0','init_bg'=>'#E3F2FD',
   'desc'=>'Libro mayor (ledger) inmutable y verificable criptográficamente. No descentralizado, propiedad de AWS.',
   'facts'=>['Historial de cambios completo e inmutable','Verificación criptográfica con SHA-256','Uso: finanzas, cadena de suministro, registros de auditoría'],
   'freq'=>1],

  ['cat'=>'database','prefix'=>'Amazon','name'=>'DMS',
   'full'=>'AWS Database Migration Service',
   'icon_url'=>null,'initials'=>'DMS','init_color'=>'#1565C0','init_bg'=>'#E3F2FD',
   'desc'=>'Migra bases de datos hacia AWS con mínimo tiempo de inactividad. Homogéneas y heterogéneas.',
   'facts'=>['La BD fuente permanece operativa durante la migración','Homogénea: MySQL→MySQL, Oracle→Oracle','Heterogénea: Oracle→Aurora (requiere AWS SCT)','Replicación continua (CDC)'],
   'freq'=>2],

  ['cat'=>'database','prefix'=>'','name'=>'Cross-Region Read Replicas',
   'full'=>'Cross-Region Read Replicas',
   'icon_url'=>null,'initials'=>'CRRR','init_color'=>'#1565C0','init_bg'=>'#E3F2FD',
   'desc'=>'Réplicas de lectura de bases de datos (RDS/Aurora) ubicadas en una región AWS diferente a la principal.',
   'facts'=>['Reducen latencia de lectura para usuarios en otras regiones','Protegen contra fallos de región completa (DR cross-region)','Los datos se replican de forma asíncrona desde la instancia primaria','Pueden promoverse a instancia primaria en caso de desastre'],
   'freq'=>2],

  ['cat'=>'database','prefix'=>'','name'=>'Multi-AZ Deployment',
   'full'=>'Multi-AZ Deployment',
   'icon_url'=>null,'initials'=>'MAZ','init_color'=>'#1565C0','init_bg'=>'#E3F2FD',
   'desc'=>'Despliegue de bases de datos en múltiples Zonas de Disponibilidad para alta disponibilidad y failover automático.',
   'facts'=>['Réplica sincrónica en standby en una AZ diferente','Failover automático en caso de fallo (1-2 min, sin intervención manual)','La réplica standby NO sirve tráfico de lectura (solo HA)','Disponible en RDS y Aurora; Aurora usa 6 copias en 3 AZs por defecto'],
   'freq'=>3],

  // ─── REDES & CDN ───────────────────────────────────────────────────────────
  ['cat'=>'network','prefix'=>'Amazon','name'=>'VPC',
   'full'=>'Amazon VPC',
   'icon_url'=>null,'initials'=>'VPC','init_color'=>'#4A148C','init_bg'=>'#F3E5F5',
   'desc'=>'Red virtual privada en la nube. Control total sobre el entorno de red (IPs, subredes, rutas, gateways).',
   'facts'=>['Subred pública: ruta al Internet Gateway','Subred privada: sin acceso directo a internet','Security Groups (stateful) vs NACLs (stateless)','VPC Peering, VPC Endpoints, PrivateLink'],
   'freq'=>3],

  ['cat'=>'network','prefix'=>'Amazon','name'=>'CloudFront',
   'full'=>'Amazon CloudFront',
   'icon_url'=>'https://cdn.simpleicons.org/amazoncloudfront/4A148C',
   'desc'=>'CDN (Red de distribución de contenido) global. Entrega contenido estático y dinámico con baja latencia.',
   'facts'=>['400+ ubicaciones de borde en 90+ ciudades','Integrado con S3, ELB, EC2, API Gateway','Protección DDoS con AWS Shield Standard (gratis)','Políticas de caché configurables por comportamiento'],
   'freq'=>3],

  ['cat'=>'network','prefix'=>'Amazon','name'=>'Route 53',
   'full'=>'Amazon Route 53',
   'icon_url'=>'https://cdn.simpleicons.org/amazonroute53/4A148C',
   'desc'=>'Servicio de DNS escalable y altamente disponible. También registra nombres de dominio.',
   'facts'=>['Routing policies: Simple, Weighted, Latency, Failover, Geolocation, Multivalue','Health checks para monitorizar endpoints','SLA del 100% de disponibilidad','Puerto 53 → nombre del servicio'],
   'freq'=>2],

  ['cat'=>'network','prefix'=>'','name'=>'Elastic Load Balancing',
   'full'=>'Elastic Load Balancing (ELB)',
   'icon_url'=>null,'initials'=>'ELB','init_color'=>'#4A148C','init_bg'=>'#F3E5F5',
   'desc'=>'Distribuye automáticamente el tráfico entre múltiples destinos (EC2, contenedores, IPs, Lambda).',
   'facts'=>['ALB (capa 7): HTTP/HTTPS, enrutamiento por contenido','NLB (capa 4): TCP/UDP, ultra baja latencia, millones rps','GLB (capa 3): inspección de paquetes con appliances de red','Health checks automáticos; elimina instancias no sanas'],
   'freq'=>3],

  ['cat'=>'network','prefix'=>'AWS','name'=>'Direct Connect',
   'full'=>'AWS Direct Connect',
   'icon_url'=>null,'initials'=>'DX','init_color'=>'#4A148C','init_bg'=>'#F3E5F5',
   'desc'=>'Conexión de red dedicada y privada desde tus instalaciones a AWS. Bypass al internet público.',
   'facts'=>['Anchos de banda: 50 Mbps a 100 Gbps','Menor latencia y más consistente que VPN por internet','Mayor ancho de banda por menos costo que VPN','No cifra por defecto (combinar con VPN para cifrado)'],
   'freq'=>2],

  ['cat'=>'network','prefix'=>'AWS','name'=>'Site-to-Site VPN',
   'full'=>'AWS Site-to-Site VPN',
   'icon_url'=>null,'initials'=>'VPN','init_color'=>'#4A148C','init_bg'=>'#F3E5F5',
   'desc'=>'Conexión VPN cifrada entre tu red local y una VPC de AWS usando internet público.',
   'facts'=>['IPSec sobre internet público (no privado como Direct Connect)','Virtual Private Gateway (VGW) en el lado AWS','Customer Gateway en tu lado (router/firewall)','Más económico que Direct Connect; más fácil de desplegar'],
   'freq'=>2],

  ['cat'=>'network','prefix'=>'Amazon','name'=>'API Gateway',
   'full'=>'Amazon API Gateway',
   'icon_url'=>null,'initials'=>'APIG','init_color'=>'#4A148C','init_bg'=>'#F3E5F5',
   'desc'=>'Crea, publica y gestiona APIs REST, HTTP y WebSocket a cualquier escala. "Puerta delantera" para apps serverless.',
   'facts'=>['Integración nativa con Lambda, HTTP backends, AWS services','Throttling, caché, autorización (IAM, Cognito, Lambda)','Hasta 10,000 rps por defecto (se puede aumentar)','Pay-per-use: por llamada de API y GB transferido'],
   'freq'=>2],

  ['cat'=>'network','prefix'=>'AWS','name'=>'Transit Gateway',
   'full'=>'AWS Transit Gateway',
   'icon_url'=>null,'initials'=>'TGW','init_color'=>'#4A148C','init_bg'=>'#F3E5F5',
   'desc'=>'Hub central para conectar múltiples VPCs y redes on-premises. Elimina topologías de peering complejas.',
   'facts'=>['Soporta hasta 5,000 VPCs por Transit Gateway','Enrutamiento dinámico con BGP','Transit Gateway Connect: integración SD-WAN con GRE','Reemplaza múltiples conexiones peering punto a punto'],
   'freq'=>2],

  ['cat'=>'network','prefix'=>'AWS','name'=>'Global Accelerator',
   'full'=>'AWS Global Accelerator',
   'icon_url'=>null,'initials'=>'GA','init_color'=>'#4A148C','init_bg'=>'#F3E5F5',
   'desc'=>'Mejora disponibilidad y rendimiento de aplicaciones usando la red global privada de fibra de AWS.',
   'facts'=>['IPs Anycast estáticas que enrutan al endpoint óptimo','Diferencia con CloudFront: tráfico sin caché (TCP/UDP)','Failover automático entre regiones en segundos','Reduce el tiempo que el tráfico viaja por internet público'],
   'freq'=>1],

  ['cat'=>'network','prefix'=>'','name'=>'VPC Peering',
   'full'=>'VPC Peering',
   'icon_url'=>null,'initials'=>'Peer','init_color'=>'#4A148C','init_bg'=>'#F3E5F5',
   'desc'=>'Conexión de red privada y directa entre dos VPCs que permite enrutar tráfico usando IPs privadas.',
   'facts'=>['Funciona entre VPCs de la misma cuenta, cuentas distintas o regiones distintas','No transitivo: A↔B y B↔C no implica A↔C (hay que crear A↔C explícito)','Sin gateway, VPN ni conexión a internet; tráfico no sale de la red AWS','Para conectar muchas VPCs, Transit Gateway escala mejor que el peering mesh'],
   'freq'=>2],

  ['cat'=>'network','prefix'=>'AWS','name'=>'Wavelength',
   'full'=>'AWS Wavelength',
   'icon_url'=>null,'initials'=>'WL','init_color'=>'#4A148C','init_bg'=>'#F3E5F5',
   'desc'=>'Extiende servicios AWS (EC2, ECS, EKS) al interior de las redes 5G de los operadores de telecomunicaciones.',
   'facts'=>['Latencia de milisegundos de un solo dígito para dispositivos móviles 5G','Las Wavelength Zones están físicamente en los data centers de los carriers','Ideal para: streaming en vivo, juegos, AR/VR, vehículos conectados, IoT','El tráfico no necesita salir de la red del carrier para llegar a AWS'],
   'freq'=>1],

  // ─── SEGURIDAD & IAM ───────────────────────────────────────────────────────
  ['cat'=>'security','prefix'=>'AWS','name'=>'IAM',
   'full'=>'AWS IAM',
   'icon_url'=>'https://cdn.simpleicons.org/awsidentityandaccessmanagement/880E4F',
   'desc'=>'Gestiona el acceso a los servicios y recursos AWS. Usuarios, grupos, roles y políticas de permisos.',
   'facts'=>['Principio de mínimo privilegio: solo los permisos necesarios','Roles: identidades sin credenciales estáticas (mejores para servicios)','MFA: segunda capa de seguridad obligatoria para root','Políticas JSON: Allow/Deny sobre Actions, Resources, Conditions'],
   'freq'=>3],

  ['cat'=>'security','prefix'=>'AWS','name'=>'Organizations',
   'full'=>'AWS Organizations',
   'icon_url'=>null,'initials'=>'Org','init_color'=>'#880E4F','init_bg'=>'#FCE4EC',
   'desc'=>'Gestión centralizada de múltiples cuentas AWS. Facturación consolidada, SCPs y gobernanza.',
   'facts'=>['SCPs (Service Control Policies): límites máximos de permisos','Facturación consolidada: descuentos por volumen combinado','OUs (Organizational Units): grupos de cuentas','Management Account: cuenta raíz de la organización'],
   'freq'=>2],

  ['cat'=>'security','prefix'=>'AWS','name'=>'Control Tower',
   'full'=>'AWS Control Tower',
   'icon_url'=>null,'initials'=>'CT','init_color'=>'#880E4F','init_bg'=>'#FCE4EC',
   'desc'=>'Configura y gobierna un entorno multi-cuenta seguro basado en mejores prácticas AWS automáticamente.',
   'facts'=>['Landing Zone: entorno multi-cuenta bien arquitectado','Guardrails: reglas preventivas (SCPs) y detectivas (Config)','Account Factory: aprovisiona nuevas cuentas con configuración estándar'],
   'freq'=>1],

  ['cat'=>'security','prefix'=>'Amazon','name'=>'Cognito',
   'full'=>'Amazon Cognito',
   'icon_url'=>'https://cdn.simpleicons.org/amazoncognito/880E4F',
   'desc'=>'Autenticación, autorización y gestión de usuarios para aplicaciones web y móviles.',
   'facts'=>['User Pools: directorio de usuarios propio','Identity Pools: credenciales AWS temporales para usuarios','Federación con Google, Facebook, Apple, SAML, OIDC','Soporta MFA, recuperación de contraseña, flujos personalizados'],
   'freq'=>2],

  ['cat'=>'security','prefix'=>'AWS','name'=>'Shield',
   'full'=>'AWS Shield',
   'icon_url'=>null,'initials'=>'Shld','init_color'=>'#880E4F','init_bg'=>'#FCE4EC',
   'desc'=>'Protección gestionada contra ataques DDoS. Standard gratuito para todos; Advanced para protección avanzada.',
   'facts'=>['Standard: automático, gratuito, protege ataques comunes L3/L4','Advanced: protección avanzada L3/L4/L7 + soporte DRT','Advanced: garantía de costos DDoS (reembolso de picos)','Advanced: dashboard en tiempo real de ataques'],
   'freq'=>2],

  ['cat'=>'security','prefix'=>'AWS','name'=>'WAF',
   'full'=>'AWS WAF',
   'icon_url'=>null,'initials'=>'WAF','init_color'=>'#880E4F','init_bg'=>'#FCE4EC',
   'desc'=>'Firewall de aplicaciones web. Protege contra SQL injection, XSS y exploits web comunes.',
   'facts'=>['Web ACLs con reglas personalizadas','Managed Rules: reglas preconfiguradas de AWS y socios','Se despliega en CloudFront, ALB, API Gateway, AppSync','Bloqueo por IP, geografía, cabeceras, cuerpo de solicitud'],
   'freq'=>2],

  ['cat'=>'security','prefix'=>'Amazon','name'=>'GuardDuty',
   'full'=>'Amazon GuardDuty',
   'icon_url'=>null,'initials'=>'GD','init_color'=>'#880E4F','init_bg'=>'#FCE4EC',
   'desc'=>'Servicio de detección de amenazas inteligente. Analiza CloudTrail, VPC Flow Logs y DNS logs con ML.',
   'facts'=>['Detección de: compromiso de instancias, cuentas, S3, EKS','No requiere instalar agentes','Hallazgos enviables a Security Hub, EventBridge','Prueba gratuita de 30 días'],
   'freq'=>2],

  ['cat'=>'security','prefix'=>'Amazon','name'=>'Inspector',
   'full'=>'Amazon Inspector',
   'icon_url'=>null,'initials'=>'Insp','init_color'=>'#880E4F','init_bg'=>'#FCE4EC',
   'desc'=>'Evaluación automática de vulnerabilidades en EC2, funciones Lambda e imágenes de contenedor.',
   'facts'=>['Escanea CVEs conocidos en paquetes de SO y código','Integrado con ECR para imágenes de contenedor','Sin agente para EC2 (usa SSM Agent)','Hallazgos con puntuación de riesgo y priorización'],
   'freq'=>1],

  ['cat'=>'security','prefix'=>'Amazon','name'=>'Macie',
   'full'=>'Amazon Macie',
   'icon_url'=>null,'initials'=>'Mac','init_color'=>'#880E4F','init_bg'=>'#FCE4EC',
   'desc'=>'Descubre y protege datos sensibles (PII, datos financieros) en Amazon S3 usando machine learning.',
   'facts'=>['Detecta: números de tarjetas, DNI, credenciales, datos médicos…','Dashboard de inventario de S3 con estado de privacidad','Hallazgos integrables con Security Hub y EventBridge'],
   'freq'=>1],

  ['cat'=>'security','prefix'=>'AWS','name'=>'CloudTrail',
   'full'=>'AWS CloudTrail',
   'icon_url'=>null,'initials'=>'CT','init_color'=>'#880E4F','init_bg'=>'#FCE4EC',
   'desc'=>'Registra todas las llamadas a la API de AWS en tu cuenta. Quién hizo qué, cuándo y desde dónde.',
   'facts'=>['Logs entregados a S3 (y opcionalmente CloudWatch Logs)','Eventos de gestión (API calls) + datos (S3 objects, Lambda)','Trail de organización: un trail para todas las cuentas','Esencial para auditoría, cumplimiento e investigación forense'],
   'freq'=>3],

  ['cat'=>'security','prefix'=>'AWS','name'=>'Config',
   'full'=>'AWS Config',
   'icon_url'=>null,'initials'=>'CFG','init_color'=>'#880E4F','init_bg'=>'#FCE4EC',
   'desc'=>'Inventario, historial de configuración y evaluación de conformidad de recursos AWS.',
   'facts'=>['Config Rules: evalúa si recursos cumplen tus políticas','Conformance Packs: conjuntos de reglas y acciones correctivas','Historial completo: cómo estaba configurado un recurso en el pasado','Diferencia con CloudTrail: CONFIG qué estado tiene; TRAIL quién lo cambió'],
   'freq'=>2],

  ['cat'=>'security','prefix'=>'AWS','name'=>'KMS',
   'full'=>'AWS KMS',
   'icon_url'=>null,'initials'=>'KMS','init_color'=>'#880E4F','init_bg'=>'#FCE4EC',
   'desc'=>'Gestión de claves criptográficas. Crea y controla claves para cifrar datos en servicios AWS.',
   'facts'=>['CMKs (Customer Managed Keys) o claves gestionadas por AWS','Integrado con S3, EBS, RDS, DynamoDB, Lambda, SSM…','Auditoría de uso de claves en CloudTrail','CloudHSM: HSMs dedicados para control total de claves (FIPS 140-2 L3)'],
   'freq'=>2],

  ['cat'=>'security','prefix'=>'AWS','name'=>'Secrets Manager',
   'full'=>'AWS Secrets Manager',
   'icon_url'=>null,'initials'=>'SM','init_color'=>'#880E4F','init_bg'=>'#FCE4EC',
   'desc'=>'Gestiona y rota automáticamente credenciales de bases de datos, claves API y otros secretos.',
   'facts'=>['Rotación automática integrada con RDS, Redshift, DocumentDB','Las apps obtienen siempre las credenciales actuales (sin hardcodear)','Cifrado con KMS, acceso controlado con IAM','Parameter Store (SSM): alternativa más económica, sin rotación automática'],
   'freq'=>2],

  ['cat'=>'security','prefix'=>'AWS','name'=>'Artifact',
   'full'=>'AWS Artifact',
   'icon_url'=>null,'initials'=>'Art','init_color'=>'#880E4F','init_bg'=>'#FCE4EC',
   'desc'=>'Portal de autoservicio para acceder a informes de conformidad de AWS (SOC, PCI, ISO, HIPAA…).',
   'facts'=>['Descarga gratuita de informes de auditoría de terceros','Gestión de acuerdos (BAA para HIPAA, NDA…)','No requiere solicitar a AWS; acceso inmediato en la consola'],
   'freq'=>1],

  ['cat'=>'security','prefix'=>'AWS','name'=>'Security Hub',
   'full'=>'AWS Security Hub',
   'icon_url'=>null,'initials'=>'SH','init_color'=>'#880E4F','init_bg'=>'#FCE4EC',
   'desc'=>'Vista centralizada del estado de seguridad. Agrega hallazgos de GuardDuty, Inspector, Macie y más.',
   'facts'=>['Verificación contra estándares: CIS AWS Benchmark, PCI DSS, NIST','Puntuación de seguridad por cuenta','Automatización de respuestas con EventBridge','Multi-cuenta con AWS Organizations'],
   'freq'=>1],

  ['cat'=>'security','prefix'=>'','name'=>'Modelo de Responsabilidad Compartida',
   'full'=>'Shared Responsibility Model',
   'icon_url'=>null,'initials'=>'SRM','init_color'=>'#880E4F','init_bg'=>'#FCE4EC',
   'desc'=>'AWS es responsable de la seguridad "de" la nube; el cliente es responsable de la seguridad "en" la nube.',
   'facts'=>['AWS gestiona: hardware, instalaciones, red global, hipervisor','Cliente gestiona: datos, SO invitado, aplicaciones, cifrado, IAM, firewall','Varía por servicio: más responsabilidad en IaaS (EC2), menos en SaaS (S3)','Regla clave: si puedes configurarlo, eres responsable de ello'],
   'freq'=>3],

  // ─── GESTIÓN & GOBERNANZA ──────────────────────────────────────────────────
  ['cat'=>'mgmt','prefix'=>'Amazon','name'=>'CloudWatch',
   'full'=>'Amazon CloudWatch',
   'icon_url'=>'https://cdn.simpleicons.org/amazoncloudwatch/4527A0',
   'desc'=>'Monitorización y observabilidad de recursos y aplicaciones AWS. Métricas, logs y alarmas en tiempo real.',
   'facts'=>['Métricas: CPU, red, disco, latencia, errores… (y personalizadas)','Alarmas: acciones automáticas (Auto Scaling, SNS, EC2)','CloudWatch Logs: centraliza logs de EC2, Lambda, RDS…','CloudWatch Dashboard: paneles personalizables'],
   'freq'=>3],

  ['cat'=>'mgmt','prefix'=>'AWS','name'=>'CloudFormation',
   'full'=>'AWS CloudFormation',
   'icon_url'=>'https://cdn.simpleicons.org/awscloudformation/4527A0',
   'desc'=>'Infraestructura como código (IaC). Define recursos AWS en plantillas JSON/YAML y AWS los crea automáticamente.',
   'facts'=>['Stack: conjunto de recursos creados desde una plantilla','StackSet: despliega stacks en múltiples cuentas/regiones','Cambios: Change Sets muestran qué cambiará antes de aplicar','Gratis: solo pagas por los recursos creados'],
   'freq'=>2],

  ['cat'=>'mgmt','prefix'=>'AWS','name'=>'Trusted Advisor',
   'full'=>'AWS Trusted Advisor',
   'icon_url'=>null,'initials'=>'TA','init_color'=>'#4527A0','init_bg'=>'#EDE7F6',
   'desc'=>'Analiza el entorno AWS y da recomendaciones en 5 categorías para optimizar costo, seguridad y más.',
   'facts'=>['5 categorías: Costo, Rendimiento, Seguridad, Tolerancia a fallos, Límites de servicio','Basic/Developer: 7 checks gratuitos','Business/Enterprise: 400+ checks completos','Checks críticos: S3 público, MFA en root, puertos peligrosos abiertos'],
   'freq'=>2],

  ['cat'=>'mgmt','prefix'=>'AWS','name'=>'Systems Manager',
   'full'=>'AWS Systems Manager',
   'icon_url'=>null,'initials'=>'SSM','init_color'=>'#4527A0','init_bg'=>'#EDE7F6',
   'desc'=>'Suite de herramientas para gestionar instancias EC2 y servidores on-premises a escala.',
   'facts'=>['Session Manager: shell a EC2 sin SSH/RDP ni bastion','Parameter Store: almacena configs y secretos','Patch Manager: parcheo automatizado de SO','Run Command: ejecuta scripts en miles de instancias'],
   'freq'=>1],

  ['cat'=>'mgmt','prefix'=>'AWS','name'=>'Cost Explorer',
   'full'=>'AWS Cost Explorer',
   'icon_url'=>null,'initials'=>'CE','init_color'=>'#4527A0','init_bg'=>'#EDE7F6',
   'desc'=>'Visualiza, analiza y gestiona costos y uso de AWS a lo largo del tiempo con gráficos interactivos.',
   'facts'=>['Informes predeterminados y personalizados','Previsión de gastos para los próximos 12 meses','Recomendaciones de Savings Plans y Reserved Instances','Desglose por servicio, cuenta, tag, región…'],
   'freq'=>2],

  ['cat'=>'mgmt','prefix'=>'AWS','name'=>'Budgets',
   'full'=>'AWS Budgets',
   'icon_url'=>null,'initials'=>'Bgt','init_color'=>'#4527A0','init_bg'=>'#EDE7F6',
   'desc'=>'Define presupuestos de costo y uso. Recibe alertas cuando el gasto real o previsto supera el umbral.',
   'facts'=>['Presupuestos de costo, uso, Savings Plans y Reserved Instances','Alertas por email y/o SNS','Acciones automáticas: aplicar SCPs, detener instancias…','Hasta 2 presupuestos gratuitos por cuenta; 0,02 USD/día adicionales'],
   'freq'=>2],

  ['cat'=>'mgmt','prefix'=>'','name'=>'Well-Architected Framework',
   'full'=>'AWS Well-Architected Framework',
   'icon_url'=>null,'initials'=>'WAF','init_color'=>'#4527A0','init_bg'=>'#EDE7F6',
   'desc'=>'Guía de mejores prácticas para construir sistemas seguros, eficientes y rentables en AWS.',
   'facts'=>['6 Pilares: Excelencia Operacional, Seguridad, Fiabilidad, Eficiencia de Rendimiento, Optimización de Costos, Sostenibilidad','Well-Architected Tool: evalúa tu carga de trabajo contra los pilares','Principio clave: "Design for failure" (diseñar para el fallo)'],
   'freq'=>3],

  ['cat'=>'mgmt','prefix'=>'AWS','name'=>'Savings Plans',
   'full'=>'AWS Savings Plans',
   'icon_url'=>null,'initials'=>'SP','init_color'=>'#4527A0','init_bg'=>'#EDE7F6',
   'desc'=>'Ahorra hasta 72% comprometiéndote a usar una cantidad en $/hora durante 1 o 3 años. Más flexible que Reserved Instances.',
   'facts'=>['Compute Savings Plans: cubre EC2, Lambda, Fargate (cualquier región/familia)','EC2 Instance Savings Plans: descuento mayor pero limitado a familia+región','Sin necesidad de especificar tipo de instancia al contratar','Alternativa moderna y flexible a las Instancias Reservadas'],
   'freq'=>2],

  ['cat'=>'mgmt','prefix'=>'','name'=>'Service Quotas',
   'full'=>'AWS Service Quotas',
   'icon_url'=>null,'initials'=>'SQ','init_color'=>'#4527A0','init_bg'=>'#EDE7F6',
   'desc'=>'Centraliza la visualización y gestión de los límites (cuotas) de servicios AWS en tu cuenta.',
   'facts'=>['Solicita aumentos de cuota desde un único lugar','Historial de solicitudes y estado en tiempo real','Alarmas de CloudWatch cuando te acercas al límite','Antes llamado "Service Limits"; accesible desde la consola AWS'],
   'freq'=>2],

  ['cat'=>'mgmt','prefix'=>'AWS','name'=>'Pricing Calculator',
   'full'=>'AWS Pricing Calculator',
   'icon_url'=>null,'initials'=>'Calc','init_color'=>'#4527A0','init_bg'=>'#EDE7F6',
   'desc'=>'Herramienta web gratuita para estimar el costo mensual de tu arquitectura AWS antes de desplegarla.',
   'facts'=>['Crea grupos de servicios para organizar estimaciones','Exporta estimaciones en CSV o comparte via URL','Accesible en calculator.aws sin cuenta AWS','No sustituye a Cost Explorer (que muestra costos reales)'],
   'freq'=>1],

  ['cat'=>'mgmt','prefix'=>'','name'=>'Cost Allocation Tags',
   'full'=>'Cost Allocation Tags',
   'icon_url'=>null,'initials'=>'Tag','init_color'=>'#4527A0','init_bg'=>'#EDE7F6',
   'desc'=>'Etiquetas clave-valor en recursos AWS que permiten desglosar costos por proyecto, equipo, entorno o departamento.',
   'facts'=>['Activar en Billing → Cost Allocation Tags','Aparecen en Cost Explorer y reportes de facturación','Ejemplo: Equipo=Backend, Entorno=Producción, Proyecto=AppX','Herramienta clave para chargeback y showback internos'],
   'freq'=>2],

  ['cat'=>'mgmt','prefix'=>'AWS','name'=>'Managed Services',
   'full'=>'AWS Managed Services',
   'icon_url'=>null,'initials'=>'AMS','init_color'=>'#4527A0','init_bg'=>'#EDE7F6',
   'desc'=>'AWS gestiona operaciones de infraestructura en tu nombre: parcheo, monitorización, backup, seguridad y más.',
   'facts'=>['Ideal para empresas sin equipo de operaciones cloud','Cumple estándares ITIL para gestión de cambios e incidentes','Incluye gestión de incidentes 24/7 y respuesta ante alertas','Permite centrarse en el negocio, no en la operativa'],
   'freq'=>1],

  ['cat'=>'mgmt','prefix'=>'AWS','name'=>'Support Plans',
   'full'=>'AWS Support Plans',
   'icon_url'=>null,'initials'=>'SUP','init_color'=>'#4527A0','init_bg'=>'#EDE7F6',
   'desc'=>'Niveles de soporte técnico de AWS: Basic, Developer, Business, Enterprise On-Ramp y Enterprise.',
   'facts'=>['Basic: gratuito, acceso a documentación y Trusted Advisor (7 checks)','Developer: emails en horario laboral, 1 contacto','Business: soporte 24/7, todas las verificaciones Trusted Advisor, API','Enterprise: TAM (Technical Account Manager), soporte crítico < 15 min','Solo Business+ incluye acceso completo a Trusted Advisor'],
   'freq'=>2],

  // ─── INTEGRACIÓN & ANÁLISIS ────────────────────────────────────────────────
  ['cat'=>'integration','prefix'=>'Amazon','name'=>'SNS',
   'full'=>'Amazon SNS',
   'icon_url'=>'https://cdn.simpleicons.org/amazonsns/006064',
   'desc'=>'Servicio de mensajería pub/sub completamente gestionado. Envía notificaciones a múltiples suscriptores.',
   'facts'=>['Publishers → Topics → Subscribers (fanout)','Suscriptores: SQS, Lambda, HTTP, email, SMS, móvil','Ideal para notificaciones, alertas y desacoplamiento de microservicios','Entrega garantizada con reintentos automáticos'],
   'freq'=>2],

  ['cat'=>'integration','prefix'=>'Amazon','name'=>'SQS',
   'full'=>'Amazon SQS',
   'icon_url'=>'https://cdn.simpleicons.org/amazonsqs/006064',
   'desc'=>'Cola de mensajes completamente gestionada. Desacopla componentes de aplicaciones distribuidas.',
   'facts'=>['Standard Queue: entrega al menos una vez, sin orden garantizado','FIFO Queue: exactamente una vez, orden estricto, 3000 msgs/seg','Visibility Timeout: oculta mensajes mientras se procesan','Dead Letter Queue (DLQ): mensajes fallidos para análisis'],
   'freq'=>2],

  ['cat'=>'integration','prefix'=>'AWS','name'=>'Step Functions',
   'full'=>'AWS Step Functions',
   'icon_url'=>null,'initials'=>'SF','init_color'=>'#006064','init_bg'=>'#E0F7FA',
   'desc'=>'Orquestador serverless de flujos de trabajo. Coordina funciones Lambda y servicios AWS en secuencias.',
   'facts'=>['Visual Workflow Designer: diseño en GUI','Estados: Task, Choice, Wait, Parallel, Map, Pass, Fail','Express Workflows: alto volumen, bajo costo, hasta 5 min','Standard Workflows: larga duración, hasta 1 año, auditable'],
   'freq'=>1],

  ['cat'=>'integration','prefix'=>'Amazon','name'=>'EventBridge',
   'full'=>'Amazon EventBridge',
   'icon_url'=>null,'initials'=>'EB','init_color'=>'#006064','init_bg'=>'#E0F7FA',
   'desc'=>'Bus de eventos serverless que conecta aplicaciones con datos de tus propias apps, AWS y SaaS.',
   'facts'=>['Antes llamado CloudWatch Events','Event Pattern Matching: reglas para filtrar y enrutar eventos','Targets: Lambda, SQS, SNS, Step Functions, API Gateway…','EventBridge Pipes: conecta fuentes con destinos con transformaciones'],
   'freq'=>1],

  ['cat'=>'integration','prefix'=>'Amazon','name'=>'Kinesis',
   'full'=>'Amazon Kinesis',
   'icon_url'=>'https://cdn.simpleicons.org/amazonkinesis/006064',
   'desc'=>'Plataforma para recopilar, procesar y analizar datos de streaming en tiempo real.',
   'facts'=>['Kinesis Data Streams: ingesta de datos en tiempo real','Kinesis Data Firehose: carga a S3, Redshift, OpenSearch (más fácil)','Kinesis Data Analytics: SQL o Apache Flink sobre streams','Kinesis Video Streams: streaming de video para ML'],
   'freq'=>2],

  ['cat'=>'integration','prefix'=>'Amazon','name'=>'Athena',
   'full'=>'Amazon Athena',
   'icon_url'=>null,'initials'=>'Ath','init_color'=>'#006064','init_bg'=>'#E0F7FA',
   'desc'=>'Servicio de consultas interactivas para analizar datos directamente en S3 con SQL estándar. Serverless.',
   'facts'=>['Sin carga de datos: consulta directamente en S3','Pago por consulta: 5 USD por TB de datos escaneados','Soporta CSV, JSON, ORC, Parquet, Avro…','Integrado con Glue Data Catalog para metadatos'],
   'freq'=>2],

  ['cat'=>'integration','prefix'=>'Amazon','name'=>'QuickSight',
   'full'=>'Amazon QuickSight',
   'icon_url'=>null,'initials'=>'QS','init_color'=>'#006064','init_bg'=>'#E0F7FA',
   'desc'=>'Servicio de Business Intelligence (BI) serverless. Crea dashboards y visualizaciones interactivas.',
   'facts'=>['SPICE: motor de cálculo en memoria para rendimiento rápido','ML Insights: anomalías, previsiones, narrativas automáticas','Embeddable: dashboards en tus propias aplicaciones','Pay-per-session: pago por sesión de usuario, no por servidor'],
   'freq'=>1],

  ['cat'=>'integration','prefix'=>'AWS','name'=>'Glue',
   'full'=>'AWS Glue',
   'icon_url'=>'https://cdn.simpleicons.org/awsglue/006064',
   'desc'=>'Servicio ETL (Extract, Transform, Load) serverless. Prepara y carga datos para análisis.',
   'facts'=>['Glue Data Catalog: repositorio centralizado de metadatos','Glue Crawlers: descubren esquemas automáticamente en S3, RDS…','Glue Studio: editor visual de trabajos ETL','Integrado con Athena, Redshift, EMR, Lake Formation'],
   'freq'=>1],

  ['cat'=>'integration','prefix'=>'Amazon','name'=>'EMR',
   'full'=>'Amazon EMR',
   'icon_url'=>null,'initials'=>'EMR','init_color'=>'#006064','init_bg'=>'#E0F7FA',
   'desc'=>'Plataforma gestionada para procesar grandes volúmenes de datos con Apache Spark, Hive, HBase, Flink y más.',
   'facts'=>['Elastic MapReduce: escala según el trabajo','Nodos Master, Core y Task (Spot para tareas)','EMR Serverless: sin gestión de clústeres','Integrado con S3, Glue, DynamoDB, HDFS'],
   'freq'=>1],

  ['cat'=>'integration','prefix'=>'AWS','name'=>'Marketplace',
   'full'=>'AWS Marketplace',
   'icon_url'=>null,'initials'=>'MKT','init_color'=>'#006064','init_bg'=>'#E0F7FA',
   'desc'=>'Tienda digital con miles de soluciones de software de terceros listas para usar en AWS.',
   'facts'=>['Compra con un clic directamente en tu cuenta AWS','SaaS, AMIs, contenedores, SageMaker models, CloudFormation templates','Facturación integrada en tu factura AWS','Categorías: seguridad, redes, BI, ML, DevOps, bases de datos…'],
   'freq'=>2],

  // ─── MACHINE LEARNING & IA ─────────────────────────────────────────────────
  ['cat'=>'ml','prefix'=>'Amazon','name'=>'SageMaker',
   'full'=>'Amazon SageMaker',
   'icon_url'=>null,'initials'=>'SM','init_color'=>'#1A237E','init_bg'=>'#E8EAF6',
   'desc'=>'Plataforma completa de machine learning. Construye, entrena y despliega modelos ML a escala.',
   'facts'=>['SageMaker Studio: IDE integrado para ML','SageMaker Autopilot: AutoML sin código','Ground Truth: etiquetado de datos con humanos','SageMaker JumpStart: modelos preentrenados y soluciones listas'],
   'freq'=>2],

  ['cat'=>'ml','prefix'=>'Amazon','name'=>'Rekognition',
   'full'=>'Amazon Rekognition',
   'icon_url'=>null,'initials'=>'Reko','init_color'=>'#1A237E','init_bg'=>'#E8EAF6',
   'desc'=>'Análisis de imágenes y videos con IA. Detección de objetos, caras, texto, actividades y más.',
   'facts'=>['Reconocimiento facial y comparación de caras','Detección de contenido inapropiado','Lectura de texto en imágenes (OCR)','Análisis de videos en tiempo real o por lotes'],
   'freq'=>1],

  ['cat'=>'ml','prefix'=>'Amazon','name'=>'Comprehend',
   'full'=>'Amazon Comprehend',
   'icon_url'=>null,'initials'=>'Comp','init_color'=>'#1A237E','init_bg'=>'#E8EAF6',
   'desc'=>'Procesamiento de lenguaje natural (NLP). Extrae información y significado de texto no estructurado.',
   'facts'=>['Sentimiento, entidades, frases clave, idioma, PII','Comprehend Medical: extrae datos médicos de texto clínico','Análisis en tiempo real o por lotes','Entrena modelos personalizados con tus propias categorías'],
   'freq'=>1],

  ['cat'=>'ml','prefix'=>'Amazon','name'=>'Polly',
   'full'=>'Amazon Polly',
   'icon_url'=>null,'initials'=>'Poly','init_color'=>'#1A237E','init_bg'=>'#E8EAF6',
   'desc'=>'Convierte texto en voz natural (TTS) con docenas de voces en múltiples idiomas.',
   'facts'=>['Neural TTS (NTTS): voces ultra-realistas','SSML: control fino de pronunciación, énfasis, pausas','Streaming en tiempo real o síntesis por lotes a S3','Incluso voces en español de España y latinoamérica'],
   'freq'=>1],

  ['cat'=>'ml','prefix'=>'Amazon','name'=>'Transcribe',
   'full'=>'Amazon Transcribe',
   'icon_url'=>null,'initials'=>'Trnsc','init_color'=>'#1A237E','init_bg'=>'#E8EAF6',
   'desc'=>'Conversión automática de voz a texto (ASR). Transcribe audio y video a texto con alta precisión.',
   'facts'=>['Identificación de interlocutores (diarización)','Redacción automática de PII','Vocabulario personalizado para jerga o nombres propios','Transcribe Medical: terminología médica especializada'],
   'freq'=>1],

  ['cat'=>'ml','prefix'=>'Amazon','name'=>'Translate',
   'full'=>'Amazon Translate',
   'icon_url'=>null,'initials'=>'Trnsl','init_color'=>'#1A237E','init_bg'=>'#E8EAF6',
   'desc'=>'Traducción de texto automática y neural entre 75+ idiomas con alta calidad.',
   'facts'=>['Basado en deep learning (Neural Machine Translation)','Terminología personalizada para traducciones específicas del sector','Traducción en tiempo real o por lotes (documentos)','Integración con Comprehend para detección de idioma'],
   'freq'=>1],

  ['cat'=>'ml','prefix'=>'Amazon','name'=>'Lex',
   'full'=>'Amazon Lex',
   'icon_url'=>null,'initials'=>'Lex','init_color'=>'#1A237E','init_bg'=>'#E8EAF6',
   'desc'=>'Construye chatbots e interfaces conversacionales con voz y texto. La tecnología de Alexa disponible para todos.',
   'facts'=>['Intents, Slots y Fulfillment Lambda','Omnicanal: web, móvil, Slack, Twilio, Amazon Connect','Integración nativa con Lambda para lógica de negocio','Lex V2: interfaz visual mejorada'],
   'freq'=>1],

  // ─── FUNDAMENTOS & ARQUITECTURA ────────────────────────────────────────────
  ['cat'=>'fundamentals','prefix'=>'','name'=>'Modelos de Despliegue Cloud',
   'full'=>'Cloud Deployment Models',
   'icon_url'=>null,'initials'=>'Cloud','init_color'=>'#4E342E','init_bg'=>'#EFEBE9',
   'desc'=>'Tres modelos de despliegue según dónde se ejecuta la infraestructura: nube pública, privada e híbrida.',
   'facts'=>['Nube pública: todo en AWS, sin hardware propio (EC2, S3, Lambda…)','Nube privada / On-premises: todo en tus propias instalaciones (VMware, OpenStack)','Nube híbrida: combinación de on-premises + nube pública (Outposts, VPN, Direct Connect)','Multi-nube: uso de varios proveedores cloud simultáneamente'],
   'freq'=>2],

  ['cat'=>'fundamentals','prefix'=>'','name'=>'Infraestructura Global AWS',
   'full'=>'AWS Global Infrastructure',
   'icon_url'=>null,'initials'=>'Glob','init_color'=>'#4E342E','init_bg'=>'#EFEBE9',
   'desc'=>'La infraestructura física de AWS: Regiones, Zonas de Disponibilidad, Edge Locations y Zonas Locales.',
   'facts'=>['Región: área geográfica con 2+ AZs (ej: eu-west-1 Irlanda). ~34 regiones','Availability Zone (AZ): 1+ data centers aislados dentro de una región. ~108 AZs','Edge Location / PoP: cachés de CloudFront. 400+ en 90+ ciudades','Local Zone: infraestructura AWS cerca de grandes ciudades (baja latencia)','Outposts: rack AWS en tus instalaciones'],
   'freq'=>3],

  ['cat'=>'fundamentals','prefix'=>'','name'=>'Modelo de Precios AWS',
   'full'=>'AWS Pricing Principles',
   'icon_url'=>null,'initials'=>'$AWS','init_color'=>'#4E342E','init_bg'=>'#EFEBE9',
   'desc'=>'AWS sigue tres principios de precios: paga solo por lo que usas, paga menos al usar más, paga menos reservando.',
   'facts'=>['Pay-as-you-go: sin costos por adelantado, sin contratos mínimos','Volume discounts: descuentos por volumen automáticos (S3, data transfer…)','Reserved capacity: descuentos de hasta 72% comprometiéndote 1-3 años','Free Tier: uso gratuito los primeros 12 meses (EC2 t2.micro, 5 GB S3…)','Data transfer: inbound siempre gratis; outbound a internet tiene costo'],
   'freq'=>3],

  ['cat'=>'fundamentals','prefix'=>'AWS','name'=>'Well-Architected: 6 Pilares',
   'full'=>'AWS Well-Architected Framework - Pilares',
   'icon_url'=>null,'initials'=>'WAP','init_color'=>'#4E342E','init_bg'=>'#EFEBE9',
   'desc'=>'Los 6 pilares del Well-Architected Framework son el estándar de buenas prácticas para arquitecturas en AWS.',
   'facts'=>['1. Excelencia Operacional: automatizar, iterar, monitorizar operaciones','2. Seguridad: proteger datos, sistemas y activos mediante control de acceso y cifrado','3. Fiabilidad: recuperarse de fallos, escalar dinámicamente (Design for failure)','4. Eficiencia de Rendimiento: usar recursos eficientemente, adaptarse a cambios','5. Optimización de Costos: evitar gastos innecesarios, medir rentabilidad','6. Sostenibilidad: minimizar impacto ambiental de la carga de trabajo'],
   'freq'=>3],

  ['cat'=>'fundamentals','prefix'=>'','name'=>'Ventajas de la Nube AWS',
   'full'=>'Ventajas del Cloud Computing',
   'icon_url'=>null,'initials'=>'VC','init_color'=>'#4E342E','init_bg'=>'#EFEBE9',
   'desc'=>'AWS identifica 6 ventajas clave del cloud computing respecto a los centros de datos tradicionales.',
   'facts'=>['1. CAPEX → OPEX: de inversión fija a gasto variable','2. Economías de escala: AWS comparte ahorros con sus clientes','3. Deja de adivinar capacidad: escala bajo demanda','4. Velocidad y agilidad: despliegue en minutos, no semanas','5. Alcance global en minutos: múltiples regiones con un clic','6. Foco en el negocio: AWS gestiona la infraestructura'],
   'freq'=>3],

  ['cat'=>'fundamentals','prefix'=>'','name'=>'AWS CAF',
   'full'=>'AWS Cloud Adoption Framework',
   'icon_url'=>null,'initials'=>'CAF','init_color'=>'#4E342E','init_bg'=>'#EFEBE9',
   'desc'=>'Marco de trabajo para guiar a las organizaciones en su adopción del cloud. 6 perspectivas de transformación.',
   'facts'=>['Negocio: alinear inversiones cloud con resultados empresariales','Personas: gestión del cambio, formación y cultura cloud','Gobernanza: riesgos, cumplimiento, licencias','Plataforma: infraestructura cloud escalable y segura','Seguridad: controles de seguridad en toda la arquitectura','Operaciones: monitorización, ITSM, continuidad del negocio'],
   'freq'=>1],

  ['cat'=>'fundamentals','prefix'=>'','name'=>'AWS Migration Strategies',
   'full'=>'Estrategias de Migración (7 Rs)',
   'icon_url'=>null,'initials'=>'7Rs','init_color'=>'#4E342E','init_bg'=>'#EFEBE9',
   'desc'=>'Las 7 estrategias (7 Rs) para migrar cargas de trabajo a la nube según el nivel de transformación.',
   'facts'=>['Retire: eliminar aplicaciones obsoletas o sin uso','Retain: mantener on-premises (no migrar todavía)','Rehost: lift & shift, mover sin cambios (ej: EC2)','Relocate: mover al cloud sin modificar OS (VMware → VMware Cloud on AWS)','Repurchase: cambiar a SaaS (ej: Salesforce, ServiceNow)','Replatform: optimizar ligeramente (ej: MySQL → RDS)','Refactor/Re-architect: rediseñar como cloud-native (microservicios, serverless)'],
   'freq'=>2],

  ['cat'=>'fundamentals','prefix'=>'','name'=>'RTO',
   'full'=>'RTO (Recovery Time Objective)',
   'icon_url'=>null,'initials'=>'RTO','init_color'=>'#4E342E','init_bg'=>'#EFEBE9',
   'desc'=>'Tiempo máximo aceptable para restaurar un servicio tras una interrupción. Define cuánto tiempo puede estar caído.',
   'facts'=>['RTO bajo → arquitectura más costosa (Multi-AZ, failover automático)','Ejemplo: RTO de 1 hora significa que el servicio debe estar operativo en ≤ 60 min','Se logra con: Multi-AZ RDS, Auto Scaling, ELB, Route 53 Failover','Complementa al RPO: juntos definen la estrategia de recuperación ante desastres'],
   'freq'=>2],

  ['cat'=>'fundamentals','prefix'=>'','name'=>'RPO',
   'full'=>'RPO (Recovery Point Objective)',
   'icon_url'=>null,'initials'=>'RPO','init_color'=>'#4E342E','init_bg'=>'#EFEBE9',
   'desc'=>'Pérdida máxima de datos aceptable medida en tiempo. Define hasta qué punto en el pasado se puede restaurar.',
   'facts'=>['RPO de 0 → replicación sincrónica; RPO de 24h → backup diario es suficiente','RPO bajo → replicación continua (Multi-AZ, CDC con DMS)','RPO alto → backups periódicos (S3 Lifecycle, RDS automated backups)','Junto con RTO define el nivel de SLA de recuperación ante desastres (DR)'],
   'freq'=>2],

  ['cat'=>'fundamentals','prefix'=>'AWS','name'=>'Local Zones',
   'full'=>'AWS Local Zones',
   'icon_url'=>null,'initials'=>'LZ','init_color'=>'#4E342E','init_bg'=>'#EFEBE9',
   'desc'=>'Extensiones de una Región AWS ubicadas físicamente cerca de grandes ciudades para reducir latencia.',
   'facts'=>['Permiten ejecutar EC2, ECS, EKS, EBS, RDS, VPC cerca del usuario final','Latencia de milisegundos de un solo dígito para aplicaciones sensibles','Conectadas a la Región padre por la red privada de alta velocidad de AWS','Diferentes de Wavelength (5G) y Outposts (instalaciones del cliente)'],
   'freq'=>1],

  ['cat'=>'ml','prefix'=>'Amazon','name'=>'Forecast',
   'full'=>'Amazon Forecast',
   'icon_url'=>null,'initials'=>'Fct','init_color'=>'#1A237E','init_bg'=>'#E8EAF6',
   'desc'=>'Previsiones de series temporales basadas en ML. Hasta 50% más preciso que métodos estadísticos tradicionales.',
   'facts'=>['Sin necesidad de experiencia en ML','Usa algoritmos de Amazon.com para demanda y ventas','Predictores AutoML o manuales (CNN-QR, DeepAR+, Prophet…)','Casos: inventario, demanda energética, tráfico web'],
   'freq'=>1],
];

$total_servicios = count($SERVICIOS);
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Chuleta de Servicios AWS - CLF-C02</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<header class="header">
  <div class="header-inner">
    <a href="index.php" class="logo">
      <div class="logo-icon">☁</div>
      <div class="logo-text">AWS <span>Quiz</span></div>
    </a>
    <nav class="nav-links">
      <a href="index.php" class="nav-link">Inicio</a>
      <a href="test.php?modo=completo" class="nav-link">Test Completo</a>
      <a href="chuleta.php" class="nav-link active">Glosario AWS CLF-C02</a>
      <a href="test.php?modulo=6" class="nav-link">Azure AZ-900</a>
      <span class="nav-link disabled">Linux LPIC-1 <span class="nav-badge">Próximamente</span></span>
      <a href="admin.php" class="nav-link">Admin</a>
    </nav>
    <button id="soundToggle" class="sound-toggle" title="Activar sonido">🔇</button>
    <script>(function(){var b=document.getElementById('soundToggle'),u=function(){var on=localStorage.getItem('quiz_sound')==='on';b.textContent=on?'🔊':'🔇';b.title=on?'Desactivar sonido':'Activar sonido';};b.onclick=function(){localStorage.setItem('quiz_sound',localStorage.getItem('quiz_sound')==='on'?'off':'on');u();};u();}());</script>
  </div>
</header>

<!-- HERO -->
<div class="chuleta-hero">
  <div class="container" style="padding-top:0;padding-bottom:0">
    <h1>Glosario de términos <span>AWS Certified Cloud Practitioner CLF-C02</span></h1>
    <p><?= $total_servicios ?> servicios esenciales para el examen · Busca, filtra y repasa</p>
    <div class="search-wrap">
      <input type="text" id="searchInput" class="search-bar"
             placeholder="Buscar servicio... (ej: Lambda, S3, IAM)"
             oninput="filterServices()" autocomplete="off">
      <i class="fas fa-search search-icon"></i>
    </div>
    <div style="margin-top:14px;font-size:0.8rem;color:rgba(255,255,255,0.5)">
      ★★★ Muy frecuente &nbsp;·&nbsp; ★★ Frecuente &nbsp;·&nbsp; ★ Puede aparecer
    </div>
  </div>
</div>

<div class="container">
<div id="searchResults" class="chuleta-grid hidden" style="margin-bottom:20px"></div>
  <!-- FILTERS -->
  <div class="cat-filters" id="catFilters">
    <button class="cat-filter-btn active" data-cat="all" onclick="setCatFilter('all',this)">
      <i class="fas fa-th"></i> Todos (<?= $total_servicios ?>)
    </button>
    <?php foreach ($CATEGORIAS as $key => $cat):
      $count = count(array_filter($SERVICIOS, fn($s) => $s['cat'] === $key));
    ?>
    <button class="cat-filter-btn" data-cat="<?= $key ?>" onclick="setCatFilter('<?= $key ?>',this)"
            style="--cat-color:<?= $cat['dot'] ?>">
      <span class="cat-dot" style="background:<?= $cat['dot'] ?>"></span>
      <?= $cat['label'] ?> (<?= $count ?>)
    </button>
    <?php endforeach; ?>
  </div>

  <!-- SECTIONS PER CATEGORY -->
  <?php foreach ($CATEGORIAS as $catKey => $cat):
    $servicios_cat = array_filter($SERVICIOS, fn($s) => $s['cat'] === $catKey);
    if (empty($servicios_cat)) continue;
  ?>
  <div class="cat-section" id="section-<?= $catKey ?>" data-cat="<?= $catKey ?>">
    <div class="cat-section-header" onclick="toggleSection('<?= $catKey ?>')">
      <span class="cat-dot" style="background:<?= $cat['dot'] ?>;width:14px;height:14px"></span>
      <i class="fas <?= $cat['icon'] ?>" style="color:<?= $cat['color'] ?>"></i>
      <span class="cat-section-title"><?= $cat['label'] ?></span>
      <span class="cat-section-count"><?= count($servicios_cat) ?> servicios</span>
      <i class="fas fa-chevron-down cat-chevron"></i>
    </div>

    <div class="chuleta-grid">
      <?php foreach ($servicios_cat as $s):
        $icon_html = '';
        if (!empty($s['icon_url'])) {
          $icon_html = '<img src="' . htmlspecialchars($s['icon_url']) . '" width="28" height="28" alt="" loading="lazy"
                           onerror="this.parentNode.innerHTML=\'<span class=\\\'service-icon-text\\\' style=\\\'color:' . $cat['color'] . '\\\'>' . htmlspecialchars($s['initials'] ?? substr($s['name'],0,4)) . '</span>\'">';
        } else {
          $initials = htmlspecialchars($s['initials'] ?? substr($s['name'], 0, 4));
          $icon_html = '<span class="service-icon-text" style="color:' . $cat['color'] . '">' . $initials . '</span>';
        }
        $stars = str_repeat('★', $s['freq']) . str_repeat('☆', 3 - $s['freq']);
        $freq_labels = [1=>'Puede aparecer', 2=>'Frecuente', 3=>'Muy frecuente'];
        $data_search = strtolower($s['full'] . ' ' . $s['name'] . ' ' . $s['desc'] . ' ' . implode(' ', $s['facts']));
      ?>
      <div class="service-card"
           data-cat="<?= $catKey ?>"
           data-search="<?= htmlspecialchars($data_search) ?>">

        <div class="service-card-top">
          <div class="service-icon" style="background:<?= $cat['bg'] ?>">
            <?= $icon_html ?>
          </div>
          <div class="service-meta">
            <?php if (!empty($s['prefix'])): ?>
            <span class="service-prefix"><?= htmlspecialchars($s['prefix']) ?></span>
            <?php endif; ?>
            <div class="service-name"><?= htmlspecialchars($s['name']) ?></div>
          </div>
        </div>

        <div class="service-desc"><?= htmlspecialchars($s['desc']) ?></div>

        <ul class="service-facts">
          <?php foreach ($s['facts'] as $fact): ?>
          <li><?= htmlspecialchars($fact) ?></li>
          <?php endforeach; ?>
        </ul>

        <div class="freq-row">
          <span class="freq-stars" title="<?= $freq_labels[$s['freq']] ?>"><?= $stars ?></span>
          <span class="freq-label"><?= $freq_labels[$s['freq']] ?></span>
        </div>
      </div>
      <?php endforeach; ?>

      <div class="no-results" id="noResults-<?= $catKey ?>" style="display:none">
        No hay servicios que coincidan con la búsqueda en esta categoría.
      </div>
    </div>
  </div>
  <?php endforeach; ?>

  <div id="globalNoResults" class="no-results hidden" style="background:#fff;border-radius:12px;margin-top:16px">
    <i class="fas fa-search" style="font-size:2rem;opacity:0.3;display:block;margin-bottom:12px"></i>
    No se encontraron servicios que coincidan con "<span id="searchTerm"></span>".
  </div>

</div>

<script>
let currentCat = 'all';

function setCatFilter(cat, btn) {
  currentCat = cat;
  document.querySelectorAll('.cat-filter-btn').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');
  filterServices();
}

function toggleSection(catKey) {
  const section = document.getElementById('section-' + catKey);
  section.classList.toggle('collapsed');
}

function filterServices() {
  const query = document.getElementById('searchInput').value.toLowerCase().trim();
  const resultsContainer = document.getElementById('searchResults');
  const globalNoRes = document.getElementById('globalNoResults');
  const allSections = document.querySelectorAll('.cat-section');
  const catFilters = document.getElementById('catFilters');

  if (query) {
    // Only query original cards inside sections (not clones in resultsContainer)
    const matchingCards = [];
    document.querySelectorAll('.cat-section .service-card').forEach(card => {
      const cardCat = card.dataset.cat;
      if (currentCat !== 'all' && cardCat !== currentCat) return;
      // Search only in service name (prefix + name), not description or facts
      const prefix = (card.querySelector('.service-prefix')?.textContent || '').toLowerCase();
      const name   = (card.querySelector('.service-name')?.textContent  || '').toLowerCase();
      if (name.includes(query) || (prefix + ' ' + name).includes(query)) {
        matchingCards.push(card.cloneNode(true));
      }
    });

    // Hide all sections and filters, show results container
    allSections.forEach(s => s.style.display = 'none');
    catFilters.style.display = 'none';
    globalNoRes.classList.add('hidden');

    if (matchingCards.length > 0) {
      resultsContainer.innerHTML = '';
      matchingCards.forEach(card => resultsContainer.appendChild(card));
      resultsContainer.classList.remove('hidden');
    } else {
      resultsContainer.classList.add('hidden');
      document.getElementById('searchTerm').textContent = query;
      globalNoRes.classList.remove('hidden');
    }
  } else {
    // Clear search: restore sections and filters
    resultsContainer.innerHTML = '';
    resultsContainer.classList.add('hidden');
    globalNoRes.classList.add('hidden');
    catFilters.style.display = '';

    allSections.forEach(section => {
      if (currentCat === 'all' || section.dataset.cat === currentCat) {
        section.style.display = '';
        section.classList.remove('collapsed');
      } else {
        section.style.display = 'none';
      }
    });
  }
}

// Keyboard shortcut: "/" focuses the search bar
document.addEventListener('keydown', e => {
  if (e.key === '/' && document.activeElement !== document.getElementById('searchInput')) {
    e.preventDefault();
    document.getElementById('searchInput').focus();
  }
  if (e.key === 'Escape') {
    document.getElementById('searchInput').value = '';
    filterServices();
  }
});
</script>
</body>
</html>
