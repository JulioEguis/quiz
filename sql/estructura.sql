-- AWS Quiz Database Structure
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS modulos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    icono VARCHAR(50) DEFAULT 'fa-cloud'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS preguntas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    modulo_id INT NOT NULL,
    pregunta TEXT NOT NULL,
    opcion_a TEXT NOT NULL,
    opcion_b TEXT NOT NULL,
    opcion_c TEXT NOT NULL,
    opcion_d TEXT NOT NULL,
    respuesta_correcta CHAR(1) NOT NULL,
    explicacion TEXT NOT NULL,
    dificultad ENUM('facil','medio','dificil') DEFAULT 'medio',
    FOREIGN KEY (modulo_id) REFERENCES modulos(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS resultados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sesion_id VARCHAR(64) NOT NULL,
    nombre_usuario VARCHAR(100) DEFAULT 'Anónimo',
    modulo_id INT,
    modo VARCHAR(50) DEFAULT 'completo',
    total_preguntas INT NOT NULL,
    correctas INT NOT NULL,
    tiempo_usado INT DEFAULT 0,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (modulo_id) REFERENCES modulos(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS respuestas_detalle (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resultado_id INT NOT NULL,
    pregunta_id INT NOT NULL,
    respuesta_dada CHAR(1),
    es_correcta TINYINT(1) DEFAULT 0,
    FOREIGN KEY (resultado_id) REFERENCES resultados(id),
    FOREIGN KEY (pregunta_id) REFERENCES preguntas(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- MÓDULOS
INSERT INTO modulos (id, nombre, descripcion, icono) VALUES
(1, 'Computación en la Nube', 'Amazon EC2, AWS Lambda, Elastic Beanstalk, ECS, EKS, Lightsail', 'fa-server'),
(2, 'Almacenamiento y Bases de Datos', 'Amazon S3, EBS, EFS, RDS, DynamoDB, Aurora, Redshift', 'fa-database'),
(3, 'Redes y Entrega de Contenido', 'Amazon VPC, CloudFront, Route 53, ELB, API Gateway, Direct Connect', 'fa-network-wired'),
(4, 'Seguridad, Identidad y Cumplimiento', 'AWS IAM, Shield, WAF, KMS, CloudTrail, GuardDuty, Cognito', 'fa-shield-alt'),
(5, 'Facturación, Precios y Arquitectura', 'AWS Pricing, Cost Explorer, Trusted Advisor, Well-Architected Framework', 'fa-dollar-sign'),
(6, 'Azure AZ-900', 'Fundamentos de Azure: cloud, identidad, seguridad, gobernanza, costes y soporte', 'fa-cloud');

-- PREGUNTAS: MÓDULO 1 - COMPUTACIÓN (40 preguntas)
INSERT INTO preguntas (modulo_id, pregunta, opcion_a, opcion_b, opcion_c, opcion_d, respuesta_correcta, explicacion, dificultad) VALUES

(1, '¿Qué servicio de AWS permite ejecutar código sin aprovisionar ni gestionar servidores?',
'Amazon EC2', 'AWS Lambda', 'Amazon ECS', 'AWS Batch',
'B', 'AWS Lambda es un servicio de cómputo serverless que ejecuta tu código en respuesta a eventos sin necesidad de gestionar servidores. Solo pagas por el tiempo de cómputo consumido.', 'facil'),

(1, '¿Cuál es la unidad mínima de cómputo en Amazon EC2?',
'Clúster', 'Instancia', 'Contenedor', 'Función',
'B', 'En Amazon EC2, una instancia es un servidor virtual en la nube. Es la unidad básica de cómputo que puedes lanzar, gestionar y terminar según tus necesidades.', 'facil'),

(1, '¿Qué tipo de instancia EC2 es ideal para cargas de trabajo con uso intensivo de memoria como bases de datos en memoria?',
'Instancias de uso general (T3)', 'Instancias optimizadas para cómputo (C5)', 'Instancias optimizadas para memoria (R5)', 'Instancias optimizadas para almacenamiento (I3)',
'C', 'Las instancias optimizadas para memoria como la familia R5 ofrecen grandes cantidades de RAM, ideales para bases de datos en memoria como Redis, SAP HANA o cargas de trabajo de big data.', 'medio'),

(1, '¿Qué modelo de precios de EC2 ofrece el mayor descuento a cambio de un compromiso de uso durante 1 o 3 años?',
'Instancias On-Demand', 'Instancias Spot', 'Instancias Reservadas', 'Instancias Dedicadas',
'C', 'Las Instancias Reservadas ofrecen descuentos de hasta el 72% comparadas con las On-Demand a cambio de un compromiso de 1 o 3 años. Son ideales para cargas de trabajo predecibles y estables.', 'facil'),

(1, '¿Cuándo es más conveniente usar Instancias Spot de EC2?',
'Para bases de datos de producción críticas', 'Para aplicaciones que pueden interrumpirse como procesamiento de datos en batch', 'Para servidores web de alto tráfico', 'Para entornos de desarrollo permanentes',
'B', 'Las Instancias Spot permiten aprovechar capacidad EC2 no utilizada con descuentos de hasta el 90%. Son ideales para cargas de trabajo tolerantes a interrupciones como procesamiento batch, análisis de big data o pruebas.', 'medio'),

(1, '¿Qué servicio de AWS facilita el despliegue y escalado de aplicaciones web sin gestionar la infraestructura subyacente?',
'Amazon EC2', 'AWS Elastic Beanstalk', 'AWS CloudFormation', 'Amazon ECS',
'B', 'AWS Elastic Beanstalk es un servicio de Platform as a Service (PaaS) que gestiona automáticamente el aprovisionamiento, balanceo de carga, escalado y monitorización de la aplicación.', 'facil'),

(1, '¿Cuál es la diferencia principal entre Amazon ECS y Amazon EKS?',
'ECS es para máquinas virtuales, EKS para contenedores', 'ECS usa Docker gestionado por AWS, EKS usa Kubernetes gestionado por AWS', 'ECS es serverless, EKS requiere servidores', 'ECS es gratuito, EKS tiene costo',
'B', 'Amazon ECS (Elastic Container Service) es el orquestador de contenedores propio de AWS, mientras que Amazon EKS (Elastic Kubernetes Service) es Kubernetes gestionado por AWS. Ambos ejecutan contenedores Docker.', 'medio'),

(1, '¿Qué servicio permite ejecutar contenedores sin gestionar servidores ni clústeres?',
'Amazon EC2', 'Amazon ECS con AWS Fargate', 'Amazon EKS con nodos EC2', 'AWS Batch',
'B', 'AWS Fargate es un motor de cómputo serverless para contenedores que funciona con Amazon ECS y EKS. Elimina la necesidad de aprovisionar y gestionar servidores para ejecutar contenedores.', 'medio'),

(1, '¿Qué característica de Amazon EC2 permite aumentar o disminuir automáticamente el número de instancias según la demanda?',
'Amazon CloudWatch', 'Elastic Load Balancing', 'Amazon EC2 Auto Scaling', 'AWS Lambda',
'C', 'Amazon EC2 Auto Scaling permite ajustar automáticamente la capacidad de cómputo según las políticas definidas, asegurando disponibilidad y optimizando costos al escalar según la demanda real.', 'facil'),

(1, '¿Qué es un Amazon Machine Image (AMI)?',
'Un servicio de inteligencia artificial de AWS', 'Una plantilla que contiene la configuración de software para lanzar una instancia EC2', 'Un tipo de instancia EC2 optimizada', 'Un servicio de monitorización',
'B', 'Una Amazon Machine Image (AMI) es una plantilla que incluye el sistema operativo, aplicaciones y configuración necesaria para lanzar instancias EC2. Sirve como punto de partida para crear instancias.', 'facil'),

(1, '¿Cuál es el servicio de AWS para crear y gestionar workloads de contenedores de forma completamente serverless?',
'Amazon ECR', 'AWS Fargate', 'Amazon ECS', 'AWS Lambda',
'B', 'AWS Fargate permite ejecutar contenedores sin gestionar la infraestructura subyacente. AWS aprovisiona, escala y mantiene automáticamente los servidores necesarios para los contenedores.', 'medio'),

(1, '¿Qué servicio de AWS es un servicio de escritorio virtual en la nube?',
'Amazon AppStream 2.0', 'Amazon WorkSpaces', 'AWS Lambda', 'Amazon Lightsail',
'B', 'Amazon WorkSpaces es un servicio de escritorio virtual (DaaS) gestionado en la nube. Permite a los usuarios acceder a sus escritorios de Windows o Linux desde cualquier dispositivo.', 'medio'),

(1, '¿Cuándo debería usar Amazon Lightsail en lugar de Amazon EC2?',
'Para grandes empresas con necesidades complejas de infraestructura', 'Para proyectos simples o pequeños negocios que necesitan servidores sencillos con precio predecible', 'Para aplicaciones que requieren escalado automático masivo', 'Para cargas de trabajo de machine learning',
'B', 'Amazon Lightsail ofrece instancias virtuales, almacenamiento y redes a precios fijos y predecibles, diseñado para proyectos simples, desarrolladores individuales o pequeñas empresas que no necesitan la complejidad de EC2.', 'medio'),

(1, '¿Qué servicio de AWS permite ejecutar trabajo de HPC (High Performance Computing)?',
'AWS Batch', 'Amazon Lightsail', 'AWS Elastic Beanstalk', 'Amazon WorkSpaces',
'A', 'AWS Batch gestiona y ejecuta eficientemente trabajos de procesamiento batch a cualquier escala. Aprovisiona dinámicamente la capacidad de cómputo óptima para los trabajos enviados.', 'dificil'),

(1, '¿Cuál es el límite de tiempo máximo de ejecución para una función AWS Lambda?',
'5 minutos', '15 minutos', '60 minutos', 'Sin límite',
'B', 'AWS Lambda tiene un tiempo máximo de ejecución de 15 minutos (900 segundos) por invocación. Para procesos más largos se deben usar otras alternativas como AWS Batch o EC2.', 'medio'),

(1, '¿Qué significa el modelo "pago por uso" en AWS Lambda?',
'Pagas una tarifa fija mensual', 'Pagas solo por el número de solicitudes y el tiempo de ejecución del código', 'Pagas por la capacidad reservada aunque no la uses', 'Pagas por hora de servidor',
'B', 'Con AWS Lambda pagas únicamente por el número de solicitudes recibidas y la duración del tiempo de ejecución del código (medido en milisegundos). No hay costos cuando el código no se ejecuta.', 'facil'),

(1, '¿Qué servicio de AWS proporciona capacidad de cómputo dedicada para cumplir requisitos de cumplimiento?',
'Instancias Spot', 'Hosts Dedicados (Dedicated Hosts)', 'Instancias Reservadas', 'AWS Outposts',
'B', 'Los Hosts Dedicados de EC2 son servidores físicos con capacidad de instancia EC2 dedicada exclusivamente a tu uso. Permiten usar licencias de software existentes y cumplir requisitos de cumplimiento.', 'dificil'),

(1, '¿Cuál de los siguientes servicios de AWS se considera "serverless"?',
'Amazon EC2', 'Amazon RDS', 'AWS Lambda', 'Amazon EKS',
'C', 'AWS Lambda es serverless porque no requiere aprovisionar, gestionar ni escalar servidores. AWS gestiona toda la infraestructura automáticamente y el código solo se ejecuta cuando es invocado.', 'facil'),

(1, '¿Qué tipo de instancia EC2 permite pausar y reanudar el estado de la instancia?',
'Instancias On-Demand', 'Instancias con Hibernación habilitada', 'Instancias Spot', 'Instancias Reservadas',
'B', 'La hibernación de EC2 permite pausar una instancia guardando el contenido de la memoria RAM en el volumen EBS raíz. Al reanudarla, recupera el estado anterior incluyendo los procesos en ejecución.', 'dificil'),

(1, '¿Qué servicio ejecuta código en respuesta a eventos de otros servicios AWS como S3, DynamoDB o SNS?',
'Amazon EC2', 'AWS Elastic Beanstalk', 'AWS Lambda', 'Amazon ECS',
'C', 'AWS Lambda puede ser invocado por eventos de más de 200 servicios de AWS, incluyendo cambios en S3, actualizaciones en DynamoDB, mensajes en SNS/SQS, llamadas API Gateway y muchos más.', 'facil'),

-- MÓDULO 2 - ALMACENAMIENTO Y BASES DE DATOS (40 preguntas)
(2, '¿Qué servicio de AWS ofrece almacenamiento de objetos escalable con alta durabilidad?',
'Amazon EBS', 'Amazon S3', 'Amazon EFS', 'Amazon Glacier',
'B', 'Amazon S3 (Simple Storage Service) es un servicio de almacenamiento de objetos que ofrece durabilidad del 99.999999999% (11 nueves). Es escalable, seguro y puede almacenar cualquier cantidad de datos.', 'facil'),

(2, '¿Cuál es la durabilidad de datos que ofrece Amazon S3?',
'99.9%', '99.99%', '99.999999999% (11 nueves)', '100%',
'C', 'Amazon S3 está diseñado para ofrecer una durabilidad del 99.999999999% (11 nueves) almacenando datos de forma redundante en múltiples instalaciones y en múltiples dispositivos dentro de cada instalación.', 'medio'),

(2, '¿Qué clase de almacenamiento de S3 es más económica para datos a los que raramente se accede y que se almacenan durante al menos 90 días?',
'S3 Standard', 'S3 Intelligent-Tiering', 'S3 Glacier Flexible Retrieval', 'S3 Standard-IA',
'C', 'S3 Glacier Flexible Retrieval (antes S3 Glacier) está diseñado para archivado de datos a largo plazo con costos muy bajos. El tiempo de recuperación varía de minutos a horas y es ideal para datos a los que se accede raramente.', 'medio'),

(2, '¿Qué tipo de almacenamiento de bloque ofrece AWS para usar con instancias EC2?',
'Amazon S3', 'Amazon EBS', 'Amazon EFS', 'Amazon FSx',
'B', 'Amazon EBS (Elastic Block Store) proporciona volúmenes de almacenamiento de bloque persistente para usar con instancias EC2. Los volúmenes EBS se replican dentro de su zona de disponibilidad para proteger contra fallos.', 'facil'),

(2, '¿Cuál es la diferencia principal entre Amazon EBS y Amazon EFS?',
'EBS es para objetos, EFS para bloques', 'EBS es un volumen de bloque para una instancia EC2, EFS es un sistema de archivos compartido para múltiples instancias', 'EBS es serverless, EFS requiere gestión', 'No hay diferencia significativa',
'B', 'Amazon EBS proporciona almacenamiento de bloque para una instancia EC2 a la vez (en la misma AZ). Amazon EFS es un sistema de archivos NFS completamente gestionado que puede ser montado simultáneamente por miles de instancias EC2.', 'medio'),

(2, '¿Qué servicio de base de datos relacional gestionado ofrece AWS?',
'Amazon DynamoDB', 'Amazon Redshift', 'Amazon RDS', 'Amazon ElastiCache',
'C', 'Amazon RDS (Relational Database Service) es un servicio gestionado que facilita la configuración, operación y escalado de bases de datos relacionales en la nube. Soporta MySQL, PostgreSQL, MariaDB, Oracle, SQL Server y Amazon Aurora.', 'facil'),

(2, '¿Qué motor de base de datos es propio de AWS y compatible con MySQL y PostgreSQL?',
'Amazon DynamoDB', 'Amazon Aurora', 'Amazon Redshift', 'Amazon DocumentDB',
'B', 'Amazon Aurora es un motor de base de datos relacional desarrollado por AWS, compatible con MySQL y PostgreSQL, que ofrece el rendimiento de bases de datos comerciales con el costo de bases de datos de código abierto.', 'medio'),

(2, '¿Para qué tipo de datos es más adecuado Amazon DynamoDB?',
'Datos relacionales con JOINs complejos', 'Datos NoSQL de clave-valor y documentos con baja latencia a escala', 'Análisis de datos y data warehousing', 'Archivado de datos a largo plazo',
'B', 'Amazon DynamoDB es una base de datos NoSQL completamente gestionada de clave-valor y documentos que ofrece rendimiento de milisegundos de un solo dígito a cualquier escala. Es ideal para aplicaciones web, móviles y de juegos.', 'facil'),

(2, '¿Qué servicio de AWS está diseñado para data warehousing y análisis de grandes volúmenes de datos?',
'Amazon RDS', 'Amazon DynamoDB', 'Amazon Redshift', 'Amazon Aurora',
'C', 'Amazon Redshift es un servicio de data warehouse completamente gestionado en la nube que permite analizar datos usando SQL estándar y herramientas de business intelligence. Puede manejar petabytes de datos.', 'medio'),

(2, '¿Cuál es el propósito de Amazon ElastiCache?',
'Almacenamiento de objetos', 'Caché en memoria para mejorar el rendimiento de aplicaciones', 'Base de datos relacional', 'Transferencia de datos',
'B', 'Amazon ElastiCache es un servicio de caché en memoria totalmente gestionado compatible con Redis y Memcached. Mejora el rendimiento de aplicaciones web al recuperar datos de cachés en memoria rápidas.', 'medio'),

(2, '¿Qué clase de S3 ajusta automáticamente el nivel de almacenamiento basándose en los patrones de acceso?',
'S3 Standard', 'S3 Intelligent-Tiering', 'S3 One Zone-IA', 'S3 Glacier',
'B', 'S3 Intelligent-Tiering mueve automáticamente los objetos entre niveles de acceso frecuente e infrecuente basándose en patrones de acceso cambiantes, optimizando los costos de almacenamiento sin impacto en el rendimiento.', 'medio'),

(2, '¿Qué es Amazon S3 Glacier Instant Retrieval?',
'Un servicio para recuperar datos en horas', 'Una clase de almacenamiento de archivado con recuperación en milisegundos', 'Un servicio de backup empresarial', 'Una clase premium de S3',
'B', 'S3 Glacier Instant Retrieval es una clase de almacenamiento de archivado que ofrece el costo más bajo para datos de larga duración a los que raramente se accede, pero que requieren recuperación en milisegundos.', 'dificil'),

(2, '¿Qué servicio de AWS permite transferir grandes cantidades de datos a AWS usando dispositivos físicos?',
'AWS DataSync', 'AWS Snowball', 'AWS Transfer Family', 'Amazon Kinesis',
'B', 'AWS Snowball es un servicio de transferencia de datos que usa dispositivos físicos seguros para transferir grandes cantidades de datos hacia y desde AWS, evitando las limitaciones de ancho de banda de la red.', 'medio'),

(2, '¿Cuál es la diferencia entre Snowball y Snowmobile?',
'Snowball es más rápido', 'Snowball maneja datos en petabytes con dispositivos portátiles; Snowmobile es un camión para migrar hasta 100 exabytes', 'Snowmobile es para pequeñas empresas', 'No hay diferencia',
'B', 'AWS Snowball usa dispositivos maletín para transferir petabytes de datos. AWS Snowmobile es un camión de 45 pies que puede transferir hasta 100 exabytes de datos, ideal para migraciones masivas de centros de datos.', 'dificil'),

(2, '¿Qué característica de Amazon RDS permite crear réplicas de lectura para mejorar el rendimiento?',
'Multi-AZ', 'Read Replicas', 'Automated Backups', 'Encryption at rest',
'B', 'Las Read Replicas de Amazon RDS permiten crear réplicas de solo lectura de la base de datos. Las consultas de lectura pueden dirigirse a estas réplicas, reduciendo la carga en la instancia principal y mejorando el rendimiento.', 'medio'),

(2, '¿Qué característica de RDS proporciona alta disponibilidad mediante replicación síncrona en otra zona de disponibilidad?',
'Read Replicas', 'Multi-AZ', 'Automated Backups', 'Performance Insights',
'B', 'La característica Multi-AZ de RDS mantiene una réplica de espera sincrónica en una zona de disponibilidad diferente. En caso de fallo, RDS conmuta automáticamente a la réplica de espera, minimizando el tiempo de inactividad.', 'medio'),

(2, '¿Qué servicio de AWS proporciona un sistema de archivos de Windows totalmente gestionado?',
'Amazon EFS', 'Amazon FSx for Windows File Server', 'Amazon S3', 'Amazon EBS',
'B', 'Amazon FSx for Windows File Server proporciona un sistema de archivos nativo de Windows totalmente gestionado compatible con aplicaciones Windows. Es accesible mediante el protocolo SMB estándar de la industria.', 'dificil'),

(2, '¿Para qué sirve AWS Database Migration Service (DMS)?',
'Crear bases de datos desde cero', 'Migrar bases de datos hacia AWS con mínimo tiempo de inactividad', 'Hacer backups de bases de datos', 'Monitorizar el rendimiento de bases de datos',
'B', 'AWS DMS ayuda a migrar bases de datos hacia AWS de forma rápida y segura. Durante la migración, la base de datos de origen permanece operativa, minimizando el tiempo de inactividad para las aplicaciones que dependen de ella.', 'medio'),

(2, '¿Qué es Amazon DocumentDB?',
'Una base de datos de grafos', 'Un servicio de base de datos compatible con MongoDB para cargas de trabajo de documentos', 'Un servicio de data warehouse', 'Una base de datos de series temporales',
'B', 'Amazon DocumentDB es un servicio de base de datos de documentos completamente gestionado, compatible con MongoDB. Está diseñado para cargas de trabajo con datos de documentos JSON a escala.', 'dificil'),

(2, '¿Cuánto tiempo retiene Amazon RDS las copias de seguridad automatizadas por defecto?',
'1 día', '7 días', '30 días', '90 días',
'B', 'Amazon RDS retiene las copias de seguridad automatizadas durante un período de retención configurable de 1 a 35 días. El valor predeterminado es 7 días. Las copias de seguridad se almacenan en Amazon S3.', 'medio'),

(2, '¿Qué servicio de AWS es una base de datos de grafos gestionada?',
'Amazon DynamoDB', 'Amazon Neptune', 'Amazon DocumentDB', 'Amazon Keyspaces',
'B', 'Amazon Neptune es un servicio de base de datos de grafos completamente gestionado que soporta modelos de grafos de propiedades y RDF. Es ideal para casos de uso como redes sociales, detección de fraude y motores de recomendación.', 'dificil'),

-- MÓDULO 3 - REDES (40 preguntas)
(3, '¿Qué es Amazon VPC?',
'Un servicio de base de datos virtual', 'Una red virtual privada en la nube AWS que permite controlar el entorno de red', 'Un servicio de DNS gestionado', 'Un servicio de balanceo de carga',
'B', 'Amazon VPC (Virtual Private Cloud) permite lanzar recursos AWS en una red virtual definida por el usuario. Proporciona control total sobre el entorno de red virtual, incluyendo selección de rango de IPs, subredes, tablas de rutas y gateways.', 'facil'),

(3, '¿Cuál es la diferencia entre una subred pública y una subred privada en una VPC?',
'Las subredes públicas son más rápidas', 'Las subredes públicas tienen ruta a Internet Gateway; las privadas no tienen acceso directo a internet', 'Las subredes privadas son más seguras y más baratas', 'No hay diferencia técnica',
'B', 'Una subred pública tiene una ruta en su tabla de rutas hacia un Internet Gateway, permitiendo comunicación directa con internet. Una subred privada no tiene esa ruta directa, protegiéndola del acceso público directo.', 'medio'),

(3, '¿Qué componente de VPC permite que las instancias en subredes privadas accedan a internet de forma saliente?',
'Internet Gateway', 'NAT Gateway', 'VPC Peering', 'Transit Gateway',
'B', 'NAT Gateway permite que las instancias en subredes privadas inicien conexiones salientes a internet, pero previene que internet inicie conexiones hacia esas instancias. Es gestionado por AWS y altamente disponible dentro de una AZ.', 'medio'),

(3, '¿Qué servicio de AWS actúa como CDN (Content Delivery Network) distribuyendo contenido globalmente?',
'Amazon Route 53', 'Amazon CloudFront', 'AWS Global Accelerator', 'Amazon API Gateway',
'B', 'Amazon CloudFront es un servicio de red de entrega de contenido (CDN) rápido que entrega datos, videos, aplicaciones y APIs de forma segura a usuarios de todo el mundo con baja latencia y altas velocidades de transferencia.', 'facil'),

(3, '¿Para qué se usa Amazon Route 53?',
'Balanceo de carga de aplicaciones', 'Servicio de DNS escalable y altamente disponible', 'Firewall de red', 'Aceleración de aplicaciones',
'B', 'Amazon Route 53 es un servicio web de DNS (Domain Name System) escalable y altamente disponible. Conecta solicitudes de usuarios a infraestructura en AWS u otros servicios, y puede registrar nombres de dominio.', 'facil'),

(3, '¿Qué tipo de Elastic Load Balancer es más adecuado para aplicaciones HTTP/HTTPS?',
'Network Load Balancer', 'Application Load Balancer', 'Classic Load Balancer', 'Gateway Load Balancer',
'B', 'Application Load Balancer (ALB) opera en la capa 7 (aplicación) y es ideal para aplicaciones HTTP/HTTPS. Puede enrutar basándose en el contenido de la solicitud (URL, cabeceras) y soporta WebSockets.', 'medio'),

(3, '¿Cuándo debería usar un Network Load Balancer?',
'Para aplicaciones web estáticas', 'Para manejar millones de solicitudes por segundo con ultra baja latencia en la capa 4 (TCP/UDP)', 'Para aplicaciones de machine learning', 'Para almacenamiento de datos',
'B', 'Network Load Balancer opera en la capa 4 (transporte) y puede manejar millones de solicitudes por segundo. Es ideal para aplicaciones TCP/UDP que requieren ultra baja latencia y rendimiento extremo.', 'medio'),

(3, '¿Qué es VPC Peering?',
'Una conexión VPN entre AWS y tu red local', 'Una conexión de red entre dos VPCs que permite enrutar tráfico entre ellas usando IPs privadas', 'Un servicio de DNS privado', 'Un firewall entre VPCs',
'B', 'VPC Peering es una conexión de red entre dos VPCs que permite enrutar tráfico entre ellas usando direcciones IPv4 o IPv6 privadas. Las instancias en cada VPC pueden comunicarse como si estuvieran en la misma red.', 'medio'),

(3, '¿Qué servicio de AWS permite conectar múltiples VPCs y redes on-premises a través de un hub central?',
'VPC Peering', 'AWS Transit Gateway', 'AWS Direct Connect', 'AWS VPN',
'B', 'AWS Transit Gateway actúa como hub central para conectar VPCs y redes on-premises. Simplifica la topología de red eliminando la necesidad de crear conexiones peering entre cada par de VPCs.', 'dificil'),

(3, '¿Qué opción proporciona una conexión dedicada y privada entre tu red local y AWS?',
'AWS Site-to-Site VPN', 'AWS Direct Connect', 'VPC Peering', 'AWS Transit Gateway',
'B', 'AWS Direct Connect proporciona una conexión de red dedicada y privada desde tus instalaciones a AWS. Ofrece mayor ancho de banda, latencia más consistente y menor costo de transferencia de datos comparado con conexiones por internet.', 'medio'),

(3, '¿Cuál es el propósito de los Security Groups en AWS?',
'Controlar el acceso a cuentas AWS', 'Actuar como firewall virtual para controlar el tráfico entrante y saliente de instancias EC2', 'Cifrar datos en reposo', 'Gestionar usuarios IAM',
'B', 'Los Security Groups actúan como firewalls virtuales para las instancias EC2, controlando el tráfico entrante y saliente. Son stateful, lo que significa que si permites tráfico entrante, la respuesta saliente se permite automáticamente.', 'facil'),

(3, '¿Cuál es la diferencia entre Security Groups y Network ACLs?',
'No hay diferencia', 'Security Groups son stateful a nivel de instancia; Network ACLs son stateless a nivel de subred', 'Security Groups son más seguros', 'Network ACLs solo controlan tráfico saliente',
'B', 'Los Security Groups son stateful y se aplican a instancias individuales. Las Network ACLs (NACLs) son stateless y se aplican a toda la subred. Las NACLs requieren reglas separadas para tráfico entrante y saliente.', 'dificil'),

(3, '¿Qué servicio de AWS permite gestionar APIs RESTful y WebSocket?',
'Amazon CloudFront', 'Amazon API Gateway', 'AWS AppSync', 'Amazon Route 53',
'B', 'Amazon API Gateway es un servicio totalmente gestionado para crear, publicar, mantener, monitorizar y proteger APIs REST, HTTP y WebSocket a cualquier escala. Maneja hasta cientos de miles de llamadas de API concurrentes.', 'medio'),

(3, '¿Qué es AWS Global Accelerator?',
'Un servicio CDN como CloudFront', 'Un servicio que mejora la disponibilidad y rendimiento usando la red global de AWS', 'Un servicio de DNS', 'Un balanceador de carga',
'B', 'AWS Global Accelerator es un servicio de red que mejora la disponibilidad y el rendimiento de las aplicaciones usando la red global de fibra de AWS. Dirige el tráfico a los endpoints de aplicación óptimos desde ubicaciones de borde.', 'dificil'),

(3, '¿Qué característica de Route 53 permite distribuir el tráfico entre múltiples recursos según diferentes criterios?',
'Hosted Zones', 'Routing Policies', 'Health Checks', 'DNS Failover',
'B', 'Las Routing Policies de Route 53 determinan cómo responde Route 53 a las consultas DNS. Incluye enrutamiento simple, ponderado, de latencia, de geolocalización, de failover y de respuesta de múltiples valores.', 'medio'),

(3, '¿Qué servicio protege aplicaciones web contra exploits comunes como SQL injection y XSS?',
'AWS Shield', 'AWS WAF', 'Amazon GuardDuty', 'AWS Firewall Manager',
'B', 'AWS WAF (Web Application Firewall) protege aplicaciones web contra exploits web comunes como SQL injection, cross-site scripting (XSS) y otros ataques. Se puede desplegar en CloudFront, ALB o API Gateway.', 'medio'),

(3, '¿Qué protocolo usa el tráfico de un sitio web HTTPS?',
'HTTP', 'TLS/SSL sobre TCP puerto 443', 'UDP', 'FTP',
'B', 'HTTPS usa TLS (Transport Layer Security, anteriormente SSL) sobre TCP en el puerto 443. TLS cifra la comunicación entre el cliente y el servidor, proporcionando confidencialidad, integridad y autenticación.', 'facil'),

(3, '¿Cuántas zonas de disponibilidad mínimas se recomiendan para aplicaciones de alta disponibilidad?',
'1', '2', '3', '5',
'B', 'Se recomienda mínimo 2 zonas de disponibilidad para alta disponibilidad. Si una AZ falla, la aplicación continúa funcionando desde la otra. Para mayor resiliencia, muchas arquitecturas usan 3 AZs.', 'facil'),

(3, '¿Qué es un Internet Gateway en AWS VPC?',
'Un tipo de servidor web', 'Un componente que permite la comunicación entre instancias VPC e internet', 'Un servicio de DNS', 'Un tipo de Load Balancer',
'B', 'Un Internet Gateway es un componente de VPC horizontalmente escalable, redundante y altamente disponible que permite la comunicación entre instancias en la VPC e internet. Soporta tráfico IPv4 e IPv6.', 'facil'),

(3, '¿Qué servicio de AWS acelera el contenido dinámico además del estático?',
'Amazon S3', 'Amazon CloudFront', 'AWS Storage Gateway', 'Amazon EFS',
'B', 'Amazon CloudFront acelera tanto el contenido estático (imágenes, videos, CSS) como el dinámico (APIs, páginas personalizadas). Usa la red global de ubicaciones de borde para entregar contenido con baja latencia.', 'medio'),

(3, '¿Cuántas regiones de AWS están disponibles globalmente aproximadamente?',
'10', '20', '33', '50',
'C', 'AWS tiene aproximadamente 33 regiones geográficas en el mundo (y continúa expandiéndose). Cada región es un área geográfica separada con múltiples zonas de disponibilidad aisladas.', 'medio'),

-- MÓDULO 4 - SEGURIDAD (40 preguntas)
(4, '¿Qué servicio de AWS gestiona identidades y accesos para usuarios y servicios?',
'Amazon Cognito', 'AWS IAM', 'AWS Organizations', 'AWS SSO',
'B', 'AWS IAM (Identity and Access Management) permite gestionar de forma segura el acceso a los servicios y recursos de AWS. Puedes crear y gestionar usuarios y grupos de AWS, y usar permisos para permitir o denegar su acceso.', 'facil'),

(4, '¿Cuál es la práctica recomendada para el usuario root de la cuenta AWS?',
'Usarlo para todas las tareas administrativas', 'Usarlo solo para tareas que requieren el usuario root y habilitar MFA', 'Compartir las credenciales con el equipo', 'Deshabilitar la cuenta root',
'B', 'La práctica recomendada es no usar el usuario root para tareas cotidianas. Debes habilitar MFA en el usuario root, crear usuarios IAM con los permisos mínimos necesarios y guardar las credenciales root de forma segura.', 'facil'),

(4, '¿Qué es el principio de mínimo privilegio en AWS IAM?',
'Dar a todos los usuarios acceso completo', 'Conceder solo los permisos necesarios para realizar las tareas requeridas', 'Rotar todas las contraseñas mensualmente', 'Usar solo roles, nunca usuarios',
'B', 'El principio de mínimo privilegio significa conceder solo los permisos necesarios para que los usuarios o servicios realicen sus tareas. Esto reduce el riesgo de acceso no autorizado y limita el impacto de credenciales comprometidas.', 'facil'),

(4, '¿Qué es un IAM Role?',
'Un tipo de usuario IAM con más permisos', 'Una identidad IAM con políticas de permisos que puede ser asumida por usuarios, servicios o aplicaciones', 'Un grupo de usuarios IAM', 'Un tipo de política IAM',
'B', 'Un IAM Role es una identidad IAM que tiene permisos asociados pero que no pertenece a un usuario específico. Puede ser asumido por usuarios IAM, servicios AWS (como EC2 o Lambda) o usuarios de cuentas externas.', 'medio'),

(4, '¿Qué servicio de AWS protege contra ataques DDoS?',
'AWS WAF', 'AWS Shield', 'Amazon GuardDuty', 'AWS Inspector',
'B', 'AWS Shield es un servicio gestionado de protección contra DDoS (Distributed Denial of Service). Shield Standard está disponible automáticamente para todos los clientes de AWS sin costo adicional.', 'facil'),

(4, '¿Cuál es la diferencia entre AWS Shield Standard y AWS Shield Advanced?',
'Shield Standard protege solo S3; Advanced protege EC2', 'Shield Standard es automático y gratuito para todos; Shield Advanced ofrece protección adicional y soporte del equipo DDoS de AWS por una tarifa', 'Shield Advanced es solo para grandes empresas', 'No hay diferencia',
'B', 'Shield Standard protege automáticamente todos los recursos AWS contra ataques DDoS comunes sin costo. Shield Advanced ofrece protección adicional más sofisticada, visibilidad en tiempo real, acceso al equipo de respuesta DDoS de AWS y garantías económicas.', 'medio'),

(4, '¿Qué servicio de AWS detecta amenazas analizando logs de CloudTrail, VPC Flow Logs y DNS?',
'AWS Inspector', 'Amazon GuardDuty', 'AWS Security Hub', 'Amazon Macie',
'B', 'Amazon GuardDuty es un servicio de detección de amenazas que monitoriza continuamente la actividad maliciosa y el comportamiento no autorizado para proteger las cuentas AWS, las cargas de trabajo y los datos almacenados en S3.', 'medio'),

(4, '¿Qué servicio de AWS detecta datos sensibles como PII en Amazon S3?',
'Amazon GuardDuty', 'Amazon Macie', 'AWS Inspector', 'AWS Config',
'B', 'Amazon Macie es un servicio de seguridad y privacidad de datos que usa machine learning para descubrir, clasificar y proteger automáticamente datos sensibles en AWS, como información personal identificable (PII).', 'dificil'),

(4, '¿Qué servicio de AWS evalúa vulnerabilidades de seguridad en instancias EC2?',
'Amazon GuardDuty', 'Amazon Macie', 'Amazon Inspector', 'AWS Config',
'C', 'Amazon Inspector es un servicio de evaluación de seguridad automatizado que ayuda a mejorar la seguridad y el cumplimiento de aplicaciones desplegadas en AWS. Evalúa automáticamente vulnerabilidades y desviaciones de las mejores prácticas.', 'medio'),

(4, '¿Qué servicio de AWS gestiona y protege claves de cifrado?',
'AWS Certificate Manager', 'AWS KMS', 'AWS Secrets Manager', 'AWS CloudHSM',
'B', 'AWS KMS (Key Management Service) es un servicio gestionado que permite crear y controlar fácilmente las claves criptográficas usadas para cifrar los datos. Está integrado con la mayoría de los servicios AWS.', 'medio'),

(4, '¿Cuál es la diferencia entre AWS KMS y AWS CloudHSM?',
'KMS es más caro', 'KMS es un servicio gestionado compartido; CloudHSM proporciona HSMs dedicados para control total de las claves', 'CloudHSM no puede cifrar datos', 'No hay diferencia',
'B', 'AWS KMS gestiona las claves en HSMs compartidos (aunque aislados por cliente). AWS CloudHSM proporciona HSMs de hardware dedicados para que puedas generar y gestionar tus propias claves con control total, cumpliendo requisitos de conformidad estrictos.', 'dificil'),

(4, '¿Qué servicio de AWS registra todas las llamadas a la API de AWS en tu cuenta?',
'Amazon CloudWatch', 'AWS CloudTrail', 'AWS Config', 'Amazon GuardDuty',
'B', 'AWS CloudTrail registra las llamadas a la API de AWS de tu cuenta, incluyendo las llamadas realizadas a través de la consola, SDK, CLI y otros servicios. Los logs se entregan a S3 y pueden usarse para auditoría y cumplimiento.', 'facil'),

(4, '¿Qué servicio de AWS permite gestionar múltiples cuentas AWS centralmente?',
'AWS IAM', 'AWS Organizations', 'AWS Control Tower', 'AWS Config',
'B', 'AWS Organizations permite gestionar y gobernar centralmente múltiples cuentas AWS. Puedes crear grupos de cuentas (OUs), aplicar políticas (SCPs) y consolidar la facturación de todas las cuentas.', 'medio'),

(4, '¿Qué son las Service Control Policies (SCPs) en AWS Organizations?',
'Políticas de facturación', 'Políticas que definen el máximo de permisos disponibles para cuentas miembro en una organización', 'Reglas de seguridad de red', 'Límites de servicio',
'B', 'Las SCPs son políticas de organización que puedes usar para gestionar permisos en tu organización. Las SCPs ofrecen control central sobre los permisos máximos disponibles para todas las cuentas en tu organización.', 'dificil'),

(4, '¿Qué es la autenticación multifactor (MFA) en AWS?',
'Usar múltiples contraseñas', 'Una capa adicional de seguridad que requiere un segundo factor de verificación además de la contraseña', 'Cifrado de datos en múltiples capas', 'Usar múltiples regiones',
'B', 'MFA agrega una capa adicional de seguridad al proceso de inicio de sesión. Además de la contraseña, los usuarios deben proporcionar un segundo factor (código OTP de un dispositivo físico o virtual) para autenticarse.', 'facil'),

(4, '¿Qué servicio de AWS gestiona credenciales de aplicación como contraseñas de bases de datos y claves API?',
'AWS KMS', 'AWS Secrets Manager', 'AWS Parameter Store', 'AWS IAM',
'B', 'AWS Secrets Manager ayuda a proteger el acceso a aplicaciones, servicios y recursos IT. Permite rotar, gestionar y recuperar fácilmente credenciales de bases de datos, claves de API y otros secretos durante su ciclo de vida.', 'medio'),

(4, '¿Qué servicio de AWS proporciona una visión centralizada del estado de seguridad en múltiples cuentas?',
'Amazon GuardDuty', 'AWS Security Hub', 'Amazon Inspector', 'AWS Config',
'B', 'AWS Security Hub proporciona una visión completa del estado de seguridad en AWS y te ayuda a verificar que tu entorno cumple los estándares de seguridad y las mejores prácticas del sector.', 'dificil'),

(4, '¿Qué servicio de AWS registra y evalúa la configuración de los recursos AWS?',
'AWS CloudTrail', 'AWS Config', 'Amazon CloudWatch', 'AWS Trusted Advisor',
'B', 'AWS Config es un servicio que proporciona un inventario de los recursos AWS, historial de configuración y notificaciones de cambios de configuración para habilitar la seguridad y la gobernanza.', 'medio'),

(4, '¿Qué es Amazon Cognito?',
'Un servicio de autenticación para aplicaciones web y móviles', 'Un servicio de base de datos NoSQL', 'Un servicio de mensajería', 'Un servicio de monitorización',
'A', 'Amazon Cognito proporciona autenticación, autorización y gestión de usuarios para aplicaciones web y móviles. Permite a los usuarios iniciar sesión directamente o a través de proveedores de identidad de terceros como Google o Facebook.', 'medio'),

(4, '¿Cuál es el propósito de AWS Artifact?',
'Almacenar artefactos de código', 'Proporcionar acceso bajo demanda a informes de conformidad y acuerdos de AWS', 'Gestionar contenedores', 'Monitorizar aplicaciones',
'B', 'AWS Artifact es un portal de autoservicio para acceder a informes de conformidad de AWS, como SOC, PCI, HIPAA y otros. También permite revisar, aceptar y gestionar acuerdos con AWS.', 'medio'),

(4, '¿Qué modelo de responsabilidad compartida define AWS?',
'AWS es responsable de todo', 'El cliente es responsable de todo', 'AWS es responsable de la seguridad DE la nube; el cliente es responsable de la seguridad EN la nube', 'La responsabilidad se divide por igual',
'C', 'El modelo de responsabilidad compartida define que AWS gestiona la seguridad de la infraestructura cloud (hardware, redes, instalaciones), mientras que el cliente gestiona la seguridad dentro de la nube (datos, SO invitado, aplicaciones, IAM).', 'facil'),

-- MÓDULO 5 - FACTURACIÓN Y ARQUITECTURA (40 preguntas)
(5, '¿Qué herramienta de AWS ayuda a estimar el costo de los servicios AWS antes de usarlos?',
'AWS Cost Explorer', 'AWS Pricing Calculator', 'AWS Budgets', 'AWS Trusted Advisor',
'B', 'AWS Pricing Calculator permite estimar el costo de la arquitectura AWS de forma detallada. Puedes modelar soluciones antes de construirlas y explorar los precios de los diferentes servicios.', 'facil'),

(5, '¿Qué servicio de AWS permite visualizar y analizar los costos y el uso de AWS?',
'AWS Budgets', 'AWS Cost Explorer', 'AWS Pricing Calculator', 'AWS Cost and Usage Report',
'B', 'AWS Cost Explorer tiene una interfaz sencilla para visualizar, entender y gestionar los costos y el uso de AWS a lo largo del tiempo. Ofrece informes predeterminados y permite crear informes personalizados.', 'facil'),

(5, '¿Qué servicio de AWS permite establecer alertas cuando los costos superan un umbral?',
'AWS Cost Explorer', 'AWS Budgets', 'AWS Pricing Calculator', 'Amazon CloudWatch',
'B', 'AWS Budgets permite establecer presupuestos de costo y uso personalizados. Recibes alertas cuando los costos o el uso supera (o se prevé que supere) el umbral presupuestado.', 'facil'),

(5, '¿Cuál es el beneficio de la facturación consolidada en AWS Organizations?',
'Reduce los costos de soporte', 'Combina el uso de todas las cuentas para potencialmente alcanzar descuentos por volumen y simplifica el pago', 'Proporciona seguridad adicional', 'Elimina los cargos de transferencia de datos',
'B', 'La facturación consolidada combina el uso de todas las cuentas de la organización en una sola factura. El uso combinado puede calificar para descuentos por volumen (tiered pricing) y simplifica el proceso de pago.', 'medio'),

(5, '¿Qué es AWS Free Tier?',
'Un nivel de soporte gratuito', 'Un conjunto de ofertas gratuitas para explorar y probar servicios AWS sin cargo', 'Un tipo de instancia EC2 gratuita permanentemente', 'Un descuento para startups',
'B', 'AWS Free Tier ofrece experiencias gratuitas para más de 100 servicios AWS. Incluye ofertas de 12 meses gratis (para nuevas cuentas), ofertas siempre gratuitas y pruebas gratuitas de corto plazo.', 'facil'),

(5, '¿Qué son los Savings Plans en AWS?',
'Planes de ahorro de energía', 'Modelos de precios flexibles que ofrecen precios reducidos a cambio de un compromiso de uso constante en dólares por hora', 'Descuentos automáticos sin compromiso', 'Planes de soporte con descuento',
'B', 'Los Savings Plans ofrecen hasta un 72% de descuento sobre los precios On-Demand a cambio de un compromiso de uso consistente (medido en $/hora) durante 1 o 3 años. Son más flexibles que las Instancias Reservadas.', 'medio'),

(5, '¿Qué es el AWS Well-Architected Framework?',
'Un conjunto de servicios de arquitectura AWS', 'Un conjunto de mejores prácticas para construir sistemas seguros, eficientes, resilientes y rentables en AWS', 'Una herramienta de monitorización', 'Un servicio de consultoría',
'B', 'El AWS Well-Architected Framework proporciona orientación arquitectural para construir infraestructuras seguras, eficientes, resilientes y rentables en AWS. Se organiza en seis pilares fundamentales.', 'facil'),

(5, '¿Cuáles son los seis pilares del AWS Well-Architected Framework?',
'Costo, Velocidad, Escalabilidad, Seguridad, Monitorización, Almacenamiento', 'Excelencia Operacional, Seguridad, Fiabilidad, Eficiencia de Rendimiento, Optimización de Costos, Sostenibilidad', 'Disponibilidad, Durabilidad, Escalabilidad, Seguridad, Costo, Velocidad', 'Cómputo, Red, Almacenamiento, Base de datos, Seguridad, Monitorización',
'B', 'Los seis pilares son: 1) Excelencia Operacional, 2) Seguridad, 3) Fiabilidad, 4) Eficiencia de Rendimiento, 5) Optimización de Costos, y 6) Sostenibilidad. Cada pilar contiene principios de diseño y áreas de mejores prácticas.', 'medio'),

(5, '¿Qué servicio de AWS proporciona recomendaciones para optimizar costos, rendimiento, seguridad y tolerancia a fallos?',
'AWS Config', 'AWS Trusted Advisor', 'AWS Cost Explorer', 'Amazon CloudWatch',
'B', 'AWS Trusted Advisor analiza tu entorno AWS y proporciona recomendaciones en cinco categorías: optimización de costos, rendimiento, seguridad, tolerancia a fallos y límites de servicio. Algunos checks son gratuitos para todos.', 'facil'),

(5, '¿Qué significa "Alta Disponibilidad" en el contexto de AWS?',
'Un sistema que nunca falla', 'Un sistema diseñado para mantener operaciones con mínimo tiempo de inactividad usando redundancia en múltiples AZs', 'Un sistema con el hardware más rápido', 'Un sistema con los costos más bajos',
'B', 'Alta disponibilidad significa diseñar sistemas que continúen operando en caso de fallos de componentes individuales. En AWS se logra distribuyendo recursos en múltiples AZs, usando Auto Scaling y servicios gestionados redundantes.', 'facil'),

(5, '¿Qué es RTO (Recovery Time Objective)?',
'El tiempo máximo aceptable para restaurar un servicio después de una interrupción', 'El punto en el tiempo al que deben restaurarse los datos', 'El costo de recuperación', 'La tasa de transferencia de datos',
'A', 'RTO (Recovery Time Objective) es el tiempo máximo aceptable para restaurar las operaciones normales después de un desastre o interrupción. Define cuánto tiempo puede estar inactivo un sistema antes de que el impacto sea inaceptable.', 'dificil'),

(5, '¿Qué es RPO (Recovery Point Objective)?',
'El tiempo para recuperar un sistema', 'El punto en el tiempo hasta el que los datos deben ser recuperados, definiendo la pérdida máxima de datos aceptable', 'El costo de los backups', 'El número de backups necesarios',
'B', 'RPO (Recovery Point Objective) define el punto en el tiempo hasta el que los datos deben restaurarse, indicando la máxima cantidad de datos que puede perderse. Un RPO de 4 horas significa que puedes perder hasta 4 horas de datos.', 'dificil'),

(5, '¿Qué modelo de precios de EC2 es mejor para una aplicación con uso variable e impredecible?',
'Instancias Reservadas', 'Instancias On-Demand', 'Instancias Spot', 'Hosts Dedicados',
'B', 'Las instancias On-Demand son ideales para cargas de trabajo impredecibles, desarrollo, pruebas o aplicaciones cuyo uso varía. No requieren compromisos a largo plazo y permiten pagar solo por el tiempo de cómputo usado.', 'facil'),

(5, '¿Qué servicio de AWS se usa para monitorizar recursos y aplicaciones en tiempo real?',
'AWS CloudTrail', 'Amazon CloudWatch', 'AWS Config', 'Amazon Inspector',
'B', 'Amazon CloudWatch es un servicio de monitorización y observabilidad que recopila datos de monitorización y operaciones en forma de logs, métricas y eventos. Permite visualizar y reaccionar a cambios en los recursos AWS.', 'facil'),

(5, '¿Qué es el modelo de pago por uso (pay-as-you-go) en AWS?',
'Pagar una tarifa fija mensual independientemente del uso', 'Pagar solo por los recursos que se consumen, sin contratos previos', 'Pagar por adelantado todo el año', 'Pagar por la capacidad máxima posible',
'B', 'El modelo pay-as-you-go de AWS significa que pagas solo por los servicios que usas, por el tiempo que los usas, sin compromisos a largo plazo. Esto permite convertir gastos de capital (CapEx) en gastos operativos (OpEx).', 'facil'),

(5, '¿Cuáles son las ventajas de usar AWS respecto a centros de datos tradicionales?',
'Mayor control físico del hardware', 'Agilidad, elasticidad, economías de escala, alcance global y modelo de pago por uso', 'Menores costos de personal técnico siempre', 'Mejor rendimiento en todos los casos',
'B', 'Las principales ventajas de AWS incluyen: agilidad para innovar rápido, elasticidad para escalar, economías de escala que reducen costos, alcance global con múltiples regiones, y el modelo pay-as-you-go que elimina inversiones iniciales.', 'facil'),

(5, '¿Qué es una Región de AWS?',
'Un centro de datos individual', 'Una ubicación geográfica física que contiene múltiples zonas de disponibilidad', 'Un conjunto de servicios disponibles en un área', 'Una zona de disponibilidad',
'B', 'Una Región de AWS es una ubicación geográfica física que contiene múltiples zonas de disponibilidad aisladas (AZs). Hay más de 30 regiones en el mundo, y cada región es completamente independiente de las demás.', 'facil'),

(5, '¿Qué es una Zona de Disponibilidad (AZ) en AWS?',
'Una región de AWS', 'Uno o más centros de datos discretos con energía, redes y conectividad redundantes dentro de una región', 'Una ubicación de borde de CloudFront', 'Un servicio de zona horaria',
'B', 'Una Zona de Disponibilidad (AZ) consiste en uno o más centros de datos discretos con energía, redes y conectividad redundantes. Las AZs dentro de una región están interconectadas con redes de alta velocidad y baja latencia.', 'facil'),

(5, '¿Qué son las ubicaciones de borde (Edge Locations) en AWS?',
'Pequeñas regiones de AWS', 'Sitios donde Amazon CloudFront almacena contenido en caché para reducir la latencia', 'Centros de datos de terceros', 'Zonas de disponibilidad adicionales',
'B', 'Las ubicaciones de borde son sitios donde Amazon CloudFront almacena copias en caché del contenido para entregarlo más rápido a los usuarios. Hay más de 400 ubicaciones de borde distribuidas globalmente.', 'medio'),

(5, '¿Qué plan de soporte de AWS incluye acceso a un Technical Account Manager (TAM)?',
'Basic', 'Developer', 'Business', 'Enterprise',
'D', 'El plan de soporte Enterprise de AWS incluye acceso a un Technical Account Manager (TAM) dedicado, que proporciona orientación técnica proactiva y coordinación de acceso a los programas y expertos de AWS.', 'medio'),

(5, '¿Cuál es el tiempo de respuesta de soporte para casos críticos de negocio en el plan Enterprise?',
'24 horas', '4 horas', '1 hora', '15 minutos',
'D', 'El plan Enterprise Support ofrece un tiempo de respuesta de 15 minutos para casos de sistema de producción crítico para el negocio caído. Este es el nivel más rápido de respuesta disponible en AWS Support.', 'dificil'),

(5, '¿Qué es AWS Marketplace?',
'Una tienda para comprar hardware de AWS', 'Un catálogo digital con software de terceros que se puede ejecutar en AWS', 'Un mercado de trabajos de AWS', 'Una plataforma de trading',
'B', 'AWS Marketplace es un catálogo digital con miles de soluciones de software de proveedores independientes que pueden desplegarse directamente en AWS. Simplifica la compra, el despliegue y la gestión de software.', 'facil'),

(5, '¿Qué servicio de AWS ayuda a migrar aplicaciones locales a AWS?',
'AWS DataSync', 'AWS Migration Hub', 'AWS Application Migration Service', 'AWS Transfer Family',
'C', 'AWS Application Migration Service (anteriormente CloudEndure Migration) simplifica y agiliza la migración de aplicaciones físicas, virtuales y cloud a AWS con una replicación de datos continua y bloque por bloque.', 'medio'),

(5, '¿Cuál es la ventaja del diseño "pay-as-you-go" para startups?',
'Permite planificar mejor el presupuesto anual', 'Elimina grandes inversiones iniciales de capital, permitiendo comenzar pequeño y crecer según sea necesario', 'Proporciona descuentos automáticos', 'Garantiza el mejor precio siempre',
'B', 'El modelo pay-as-you-go es ideal para startups porque elimina las grandes inversiones de capital en hardware e infraestructura. Las startups pueden lanzar con costos mínimos y escalar la infraestructura a medida que crecen.', 'facil'),

(5, '¿Qué es AWS Cost and Usage Report?',
'Un informe mensual enviado por email', 'El conjunto más detallado de datos de costos y uso de AWS disponible para análisis', 'Una calculadora de precios', 'Un informe de auditoría',
'B', 'AWS Cost and Usage Report (CUR) contiene el conjunto más completo de datos de costos y uso de AWS. Puede entregarse a S3 y analizarse con herramientas como Amazon Athena o Amazon QuickSight.', 'dificil'),

(5, '¿Qué principio de diseño de la nube recomienda probar los sistemas para entender cómo fallan?',
'Diseño para fallos (Design for failure)', 'Escalado horizontal', 'Desacoplamiento de componentes', 'Automatización',
'A', 'El principio de "Design for failure" recomienda asumir que los componentes individuales fallarán y diseñar sistemas para seguir funcionando. En AWS esto implica usar múltiples AZs, Auto Scaling y servicios gestionados redundantes.', 'medio'),

(5, '¿Qué herramienta de AWS permite lanzar nuevas cuentas AWS con configuración de seguridad estándar?',
'AWS Organizations', 'AWS Control Tower', 'AWS Config', 'AWS CloudFormation',
'B', 'AWS Control Tower proporciona la forma más fácil de configurar y gobernar un entorno multi-cuenta AWS seguro basado en las mejores prácticas de AWS. Automatiza la configuración de nuevas cuentas con guardrails predefinidos.', 'dificil'),

(5, '¿Qué es AWS CloudFormation?',
'Un servicio de monitorización', 'Un servicio que permite modelar y provisionar infraestructura AWS como código (IaC)', 'Un servicio de mensajería', 'Un tipo de base de datos',
'B', 'AWS CloudFormation proporciona un lenguaje común para modelar y provisionar recursos de AWS e infraestructura de terceros en tu entorno de nube. Permite crear y gestionar recursos usando plantillas (JSON o YAML).', 'medio'),

(5, '¿Qué tipo de gasto convierte AWS al pasar de centro de datos propio a la nube?',
'Convierte CapEx en CapEx más alto', 'Convierte CapEx (gastos de capital) en OpEx (gastos operativos)', 'No cambia el tipo de gasto', 'Convierte OpEx en CapEx',
'B', 'AWS permite convertir grandes gastos de capital (CapEx) como compra de servidores en gastos operativos variables (OpEx). En lugar de invertir en hardware por adelantado, pagas solo por lo que consumes mensualmente.', 'facil'),

(5, '¿Cuál de los siguientes es un beneficio CLAVE de la computación en la nube según AWS?',
'Control total del hardware físico', 'Eliminación de la necesidad de planificar la capacidad con anticipación', 'Menores costos de cumplimiento normativo siempre', 'Acceso exclusivo a los últimos procesadores',
'B', 'Una ventaja clave de la nube es que elimina la necesidad de planificar capacidad con meses de anticipación. Puedes aprovisionar recursos en minutos y escalar hacia arriba o hacia abajo según la demanda real.', 'facil');

-- MÓDULO 1 ADICIONALES (19 más → total 40)
INSERT INTO preguntas (modulo_id, pregunta, opcion_a, opcion_b, opcion_c, opcion_d, respuesta_correcta, explicacion, dificultad) VALUES
(1,'¿Qué significa EC2 en Amazon EC2?','Elastic Compute Cloud','Enterprise Computing Center','Extended Cloud Computing','Elastic Container Cloud','A','EC2 significa Elastic Compute Cloud. Es el servicio de computación en la nube de AWS que proporciona capacidad de cómputo redimensionable en la nube.','facil'),
(1,'¿Qué es una instancia EC2 de uso general T3?','Una instancia optimizada para cómputo intensivo','Una instancia con balance entre cómputo, memoria y red, ideal para cargas de trabajo moderadas','Una instancia para machine learning','Una instancia dedicada para bases de datos','B','Las instancias T3 son de uso general con balance entre CPU, memoria y rendimiento de red. Ofrecen rendimiento de CPU en ráfaga y son ideales para cargas de trabajo que no necesitan CPU de forma continua.','facil'),
(1,'¿Qué servicio de AWS permite ejecutar aplicaciones de escritorio virtualizadas en la nube para streaming a usuarios?','Amazon WorkSpaces','Amazon AppStream 2.0','Amazon EC2','AWS Lambda','B','Amazon AppStream 2.0 es un servicio de streaming de aplicaciones completamente gestionado que permite entregar aplicaciones de escritorio a cualquier dispositivo mediante un navegador web.','medio'),
(1,'¿Qué es AWS Outposts?','Un servicio de monitorización remota','Una familia de soluciones que lleva la infraestructura y servicios de AWS a las instalaciones del cliente','Un servicio de backup remoto','Un tipo de instancia EC2 especial','B','AWS Outposts lleva la infraestructura, servicios, APIs y herramientas nativas de AWS a cualquier centro de datos, espacio de colocación u instalación local. Permite ejecutar cargas de trabajo en instalaciones propias con la misma experiencia AWS.','dificil'),
(1,'¿Cuándo conviene usar AWS Lambda en lugar de EC2?','Siempre que se necesite un servidor web','Para funciones cortas basadas en eventos que escalan automáticamente sin gestión de servidores','Para aplicaciones que requieren más de 15 minutos de ejecución','Para bases de datos relacionales','B','Lambda es ideal para funciones cortas y basadas en eventos (máx 15 min). EC2 es mejor para aplicaciones de larga ejecución, con estado, o que requieren control del sistema operativo.','medio'),
(1,'¿Qué servicio de AWS ejecuta contenedores Docker en serverless sin gestionar clústeres?','Amazon ECS con EC2','Amazon EKS con nodos administrados','AWS Fargate','Amazon Lightsail Containers','C','AWS Fargate es el motor de cómputo serverless para ECS y EKS. Elimina la necesidad de provisionar y gestionar servidores. Solo defines los requisitos de CPU y memoria por contenedor.','medio'),
(1,'¿Qué tipo de instancia EC2 es mejor para aplicaciones de machine learning con GPU?','Instancias de uso general M5','Instancias optimizadas para cómputo C5','Instancias aceleradas con GPU (P4, G4)','Instancias optimizadas para memoria R5','C','Las instancias de la familia P y G de EC2 incluyen GPUs de NVIDIA y son ideales para machine learning, renderizado de gráficos, procesamiento de video y computación GPU de propósito general.','medio'),
(1,'¿Qué es Amazon EC2 Image Builder?','Un servicio de edición de imágenes','Un servicio para automatizar la creación, gestión y despliegue de AMIs personalizadas y seguras','Un servicio de galería de imágenes S3','Un tipo de snapshot de EBS','B','EC2 Image Builder simplifica la creación, prueba y distribución de imágenes de máquinas virtuales y contenedores. Automatiza el proceso de construcción de AMIs actualizadas y seguras.','dificil'),
(1,'¿Qué característica permite a EC2 crecer automáticamente para manejar picos de tráfico?','Elastic IP','Auto Scaling','Elastic Load Balancer','Reserved Capacity','B','Amazon EC2 Auto Scaling permite mantener la disponibilidad y ajustar automáticamente la capacidad EC2. Puedes configurar políticas de escalado basadas en métricas de CloudWatch.','facil'),
(1,'¿Qué es una Elastic IP en AWS?','Una dirección IP que cambia con cada reinicio','Una dirección IPv4 estática diseñada para computación en nube dinámica','Una dirección IP interna de VPC','Un tipo de balanceador de carga','B','Una Elastic IP es una dirección IPv4 pública estática que puedes asignar a cualquier instancia EC2 en tu cuenta. No cambia si detienes o reinicias la instancia, útil para aplicaciones que necesitan IP fija.','medio'),
(1,'¿Cuál es la ventaja de las instancias EC2 Spot sobre On-Demand?','Son más confiables','Cuestan hasta un 90% menos pero pueden ser interrumpidas','Son permanentemente más rápidas','No requieren configuración','B','Las instancias Spot permiten aprovechar capacidad EC2 no utilizada con descuentos de hasta el 90%. La contrapartida es que AWS puede interrumpirlas con 2 minutos de aviso cuando necesite la capacidad.','medio'),
(1,'¿Qué es una Dedicated Instance en EC2?','Una instancia que solo ejecuta un tipo de aplicación','Una instancia EC2 que corre en hardware dedicado a un solo cliente AWS, pero puede compartir hardware con otras instancias del mismo cliente','Un servidor físico completo dedicado a un cliente','Una instancia con rendimiento garantizado','B','Las Dedicated Instances son instancias EC2 que se ejecutan en VPC en hardware dedicado a un solo cliente. A diferencia de los Dedicated Hosts, no se garantiza el servidor físico específico entre paradas/reinicios.','dificil'),
(1,'¿Qué servicio permite ejecutar código en AWS sin pensar en servidores, sistemas operativos ni parches?','Amazon EC2','AWS Lambda','Amazon ECS con EC2','Amazon RDS','B','AWS Lambda es el servicio serverless emblemático de AWS. El usuario solo sube el código y define los triggers. AWS gestiona automáticamente la infraestructura, el escalado, la disponibilidad y los parches.','facil'),
(1,'¿Qué es Amazon Elastic Container Registry (ECR)?','Un servicio de monitorización de contenedores','Un registro privado de imágenes Docker completamente gestionado y altamente disponible','Un servicio de orquestación de contenedores','Un tipo de contenedor de almacenamiento','B','Amazon ECR es un servicio de registro de contenedores completamente gestionado que facilita almacenar, gestionar, compartir e implementar imágenes y artefactos de contenedor. Se integra con ECS, EKS y AWS Lambda.','medio'),
(1,'¿Qué modelo de instancia EC2 es mejor para un servidor web con tráfico constante durante 3 años?','On-Demand','Spot','Reserved (Instancia Reservada)','Dedicated Host','C','Para cargas de trabajo predecibles y constantes de 1-3 años, las Instancias Reservadas ofrecen el mayor ahorro (hasta 72%). El compromiso a 3 años con pago total por adelantado ofrece el mayor descuento.','medio'),
(1,'¿Qué es AWS Batch?','Un servicio de base de datos por lotes','Un servicio para ejecutar eficientemente trabajos de procesamiento batch a cualquier escala en AWS','Un tipo de política de IAM','Un servicio de almacenamiento de archivos','B','AWS Batch gestiona dinámicamente el aprovisionamiento de cómputo óptimo para ejecutar trabajos de procesamiento batch. Elimina la necesidad de instalar y gestionar software de cómputo por lotes.','medio'),
(1,'¿Cuánto tiempo puede ejecutarse como máximo una tarea en AWS Fargate?','15 minutos','4 horas','Sin límite de tiempo (hasta que se detenga)','24 horas','C','Las tareas en AWS Fargate (y ECS en general) no tienen un límite de tiempo fijo como Lambda. Pueden ejecutarse continuamente hasta que se detengan manualmente o por la aplicación, lo que las hace aptas para servicios de larga duración.','dificil'),
(1,'¿Qué es Amazon Lightsail y para qué tipo de usuario está diseñado?','Un servicio enterprise de alta complejidad','Un servicio sencillo de VPS con precio fijo, diseñado para desarrolladores, pequeñas empresas y proyectos simples','Un servicio de almacenamiento en la nube','Un servicio de DNS avanzado','B','Amazon Lightsail ofrece instancias virtuales (VPS), contenedores, almacenamiento, bases de datos y redes con precios fijos y predecibles. Tiene una interfaz simplificada ideal para quienes no necesitan la complejidad de EC2.','facil'),
(1,'¿Qué característica de EC2 permite hacer snapshots del estado completo de una instancia y restaurarla más tarde?','Elastic IP','AMI + Hibernación de EC2','Auto Scaling','Elastic Load Balancing','B','La hibernación de EC2 guarda el contenido de la RAM en el volumen EBS raíz. Al restaurar, la instancia recupera exactamente el mismo estado, incluyendo memoria y procesos en ejecución, sin necesidad de reiniciar el SO.','dificil'),

-- MÓDULO 2 ADICIONALES (18 más → total 40)
(2,'¿Qué clase de almacenamiento S3 es la más económica para datos raramente accedidos en una sola AZ?','S3 Standard','S3 Standard-IA','S3 One Zone-IA','S3 Glacier','C','S3 One Zone-IA almacena datos en una sola zona de disponibilidad, lo que lo hace un 20% más barato que S3 Standard-IA. Es adecuado para datos que se pueden recrear fácilmente o copias de seguridad secundarias.','medio'),
(2,'¿Qué es Amazon S3 Transfer Acceleration?','Un servicio para comprimir datos S3','Una función que acelera las transferencias hacia S3 usando las ubicaciones de borde de CloudFront','Un tipo de bucket S3 de alta velocidad','Una función de cifrado acelerado','B','S3 Transfer Acceleration permite subidas rápidas y seguras de largas distancias entre el cliente y un bucket S3. Usa los puntos de presencia de Amazon CloudFront para encaminar el tráfico por la red global de AWS.','dificil'),
(2,'¿Qué es el versionado (versioning) en Amazon S3?','Un sistema de copias de seguridad automáticas','Una función que mantiene múltiples versiones de un objeto en el mismo bucket','Un tipo de replicación entre regiones','Una función de logging','B','El versionado de S3 permite mantener múltiples variantes de un objeto en el mismo bucket. Protege contra borrados accidentales y permite recuperar versiones anteriores de cualquier objeto.','medio'),
(2,'¿Qué es Amazon S3 Object Lock?','Un mecanismo para cifrar objetos S3','Una función para almacenar objetos usando el modelo WORM (Write Once Read Many), previniendo borrado o sobreescritura','Un tipo de ACL de S3','Un servicio de auditoría de S3','B','S3 Object Lock permite almacenar objetos usando un modelo WORM. Puede usarse en modo Governance o Compliance, siendo útil para cumplimiento normativo que requiere inmutabilidad de datos.','dificil'),
(2,'¿Qué servicio de AWS proporciona un sistema de archivos NFS completamente gestionado para usar con servicios AWS y servidores locales?','Amazon EBS','Amazon S3','Amazon EFS','Amazon FSx','C','Amazon EFS (Elastic File System) proporciona almacenamiento de archivos NFS completamente gestionado, elástico y compartido. Se puede montar simultáneamente en miles de instancias EC2 en múltiples AZs.','medio'),
(2,'¿Cuál es la diferencia entre Amazon Aurora y Amazon RDS para MySQL?','No hay diferencia','Aurora ofrece hasta 5x el rendimiento de MySQL en RDS, con almacenamiento auto-escalable y alta disponibilidad automática','Aurora es más barato en todos los casos','RDS MySQL soporta más regiones','B','Amazon Aurora es un motor de base de datos compatible con MySQL y PostgreSQL, pero arquitectónicamente diferente. Ofrece mayor rendimiento, almacenamiento que escala automáticamente hasta 128 TiB y alta disponibilidad integrada.','medio'),
(2,'¿Qué es Amazon DynamoDB Accelerator (DAX)?','Un tipo de índice de DynamoDB','Una caché en memoria totalmente gestionada para DynamoDB que reduce la latencia de microsegundos a nanosegundos','Un servicio de backup para DynamoDB','Una función de cifrado de DynamoDB','B','Amazon DAX es un servicio de caché en memoria completamente gestionado y altamente disponible para DynamoDB. Ofrece latencias de respuesta en microsegundos, incluso para millones de solicitudes por segundo.','dificil'),
(2,'¿Qué característica de Amazon RDS facilita la recuperación ante desastres en otra región?','Multi-AZ','Cross-Region Read Replicas','Automated Backups','Performance Insights','B','Las Cross-Region Read Replicas de RDS replican datos de forma asíncrona a otra región AWS. Pueden promoverse a instancias principales independientes, facilitando la recuperación ante desastres y mejorando la latencia de lectura global.','dificil'),
(2,'¿Qué es Amazon Redshift Spectrum?','Un servicio de BI','Una función que permite consultar datos directamente en S3 sin necesidad de cargarlos en Redshift','Un tipo de nodo Redshift','Un servicio de streaming de datos','B','Redshift Spectrum permite ejecutar consultas directamente sobre exabytes de datos no estructurados en Amazon S3 sin necesidad de cargarlos ni transformarlos. Extiende el data warehousing más allá del clúster Redshift.','dificil'),
(2,'¿Qué servicio de AWS es una base de datos de series temporales completamente gestionada?','Amazon DynamoDB','Amazon Timestream','Amazon Neptune','Amazon QLDB','B','Amazon Timestream es un servicio de base de datos de series temporales rápido, escalable y completamente gestionado, diseñado para datos IoT y operacionales que se indexan por tiempo.','dificil'),
(2,'¿Qué es AWS Storage Gateway?','Un tipo de volumen EBS','Un servicio híbrido que conecta aplicaciones on-premises con almacenamiento en la nube AWS','Un gateway de Internet para VPC','Un servicio de transferencia de archivos','B','AWS Storage Gateway es un servicio de almacenamiento en la nube híbrido que permite al software on-premises usar almacenamiento en la nube AWS. Disponible en tres tipos: File Gateway, Volume Gateway y Tape Gateway.','medio'),
(2,'¿Qué política de ciclo de vida de S3 permite mover objetos automáticamente entre clases de almacenamiento?','S3 Replication','S3 Lifecycle Rules','S3 Versioning','S3 Object Lock','B','Las reglas de ciclo de vida de S3 permiten automatizar la transición de objetos entre clases de almacenamiento (ej: de Standard a Glacier después de 90 días) y expirar objetos después de un período definido.','medio'),
(2,'¿Qué servicio de AWS es una base de datos de libro mayor (ledger) inmutable y verificable criptográficamente?','Amazon DynamoDB','Amazon QLDB','Amazon Neptune','Amazon Timestream','B','Amazon QLDB (Quantum Ledger Database) es una base de datos de libro mayor completamente gestionada. Proporciona un log de transacciones transparente, inmutable y verificable criptográficamente, siendo propiedad exclusiva de AWS (no descentralizado).','dificil'),
(2,'¿Cuántos bytes tiene 1 TB (Terabyte)?','1,000,000 bytes','1,000,000,000 bytes','1,000,000,000,000 bytes','1,073,741,824 bytes','C','Un Terabyte (TB) equivale a 1 billón (10^12) de bytes en el sistema decimal que usa AWS para medir almacenamiento. En binario sería 1 TiB = 1,099,511,627,776 bytes.','medio'),
(2,'¿Qué servicio de AWS facilita la migración de cargas de trabajo de bases de datos a AWS de forma continua?','AWS DataSync','AWS Database Migration Service (DMS)','AWS Snowball','AWS Transfer Family','B','AWS DMS replica datos continuamente desde la fuente hacia el destino con mínima interrupción. Soporta homogéneas (MySQL a MySQL) y heterogéneas (Oracle a Aurora) migraciones.','medio'),
(2,'¿Qué opción de Amazon RDS permite escalar automáticamente la capacidad de almacenamiento sin tiempo de inactividad?','Multi-AZ','RDS Storage Auto Scaling','Read Replicas','Performance Insights','B','RDS Storage Auto Scaling detecta automáticamente cuando el almacenamiento disponible se está agotando y escala automáticamente sin tiempo de inactividad, hasta el límite máximo especificado.','medio'),
(2,'¿Qué tipo de almacenamiento EBS ofrece el mayor rendimiento con SSD de alto IOPS?','EBS General Purpose SSD (gp3)','EBS Provisioned IOPS SSD (io2 Block Express)','EBS Throughput Optimized HDD (st1)','EBS Cold HDD (sc1)','B','EBS io2 Block Express ofrece hasta 256,000 IOPS y 4,000 MB/s de throughput por volumen. Es el tipo de volumen EBS de mayor rendimiento, diseñado para aplicaciones críticas de I/O intensivo.','dificil'),
(2,'¿Qué es la replicación entre regiones (Cross-Region Replication) en Amazon S3?','Una función de backup automático','Una función que replica automáticamente objetos de un bucket S3 a un bucket en otra región AWS','Un tipo de versioning avanzado','Un servicio de sincronización de datos','B','La replicación entre regiones de S3 copia automáticamente objetos entre buckets en diferentes regiones AWS. Se usa para cumplimiento, latencia reducida, replicación de logs, y recuperación ante desastres.','medio'),
(2,'¿Qué servicio de AWS gestiona bases de datos de caché Redis o Memcached?','Amazon DynamoDB','Amazon ElastiCache','Amazon RDS','Amazon MemoryDB','B','Amazon ElastiCache es un servicio de almacenamiento de datos en memoria completamente gestionado que soporta Redis y Memcached. Mejora el rendimiento de aplicaciones web al recuperar datos de cachés de alta velocidad.','medio'),

-- MÓDULO 3 ADICIONALES (18 más → total 40)
(3,'¿Qué es un Availability Zone (AZ) en términos de red?','Una región de AWS','Uno o más centros de datos físicamente separados dentro de una región, conectados con redes de baja latencia','Un punto de presencia de CloudFront','Una zona DNS privada','B','Cada AZ es un centro de datos físicamente separado dentro de una región AWS, con energía, refrigeración y redes independientes. Están interconectados con fibra privada de alta velocidad para replicación sincrónica.','facil'),
(3,'¿Cuál es el propósito de un Virtual Private Gateway (VGW) en AWS?','Conectar subredes dentro de una VPC','El lado AWS de una conexión VPN o Direct Connect con la red on-premises','Gestionar acceso a internet desde una VPC','Un tipo de balanceador de carga','B','Un Virtual Private Gateway (VGW) es el concentrador VPN del lado AWS en una conexión VPN site-to-site o Direct Connect. Se adjunta a la VPC y permite el tráfico cifrado entre AWS y la red local.','dificil'),
(3,'¿Qué es AWS PrivateLink?','Una conexión privada a internet','Un servicio que permite acceder a servicios AWS o de terceros de forma privada sin exponer tráfico a internet','Un tipo de VPN','Una red privada dedicada','B','AWS PrivateLink permite acceder a servicios hospedados en AWS de forma privada usando IPs privadas de tu VPC. El tráfico no atraviesa internet público, mejorando la seguridad y reduciendo la latencia.','dificil'),
(3,'¿Qué es un punto de presencia (PoP) de AWS?','Una región completa de AWS','Una ubicación de borde o caché regional de CloudFront para entrega de contenido con baja latencia','Un centro de datos de AWS','Una zona de disponibilidad','B','Los puntos de presencia incluyen ubicaciones de borde (para CloudFront, Route 53, AWS Shield) y cachés regionales. Hay más de 400 puntos de presencia en más de 90 ciudades de 50+ países.','medio'),
(3,'¿Qué tipo de enrutamiento de Route 53 distribuye el tráfico basándose en el país del usuario?','Routing de latencia','Routing de geolocalización','Routing ponderado','Routing de failover','B','El routing de geolocalización de Route 53 dirige el tráfico basándose en la ubicación geográfica del usuario (continente, país o estado de EE.UU.). Permite personalizar el contenido según la región del usuario.','medio'),
(3,'¿Cuál es la diferencia entre CloudFront y S3 Transfer Acceleration?','No hay diferencia','CloudFront es un CDN para distribución de contenido a usuarios finales; S3 Transfer Acceleration acelera las subidas hacia S3 desde ubicaciones remotas','CloudFront es más barato siempre','S3 Transfer Acceleration solo funciona con HTTPS','B','CloudFront distribuye contenido cached a usuarios finales con baja latencia. S3 Transfer Acceleration usa las mismas ubicaciones de borde pero para acelerar las transferencias de datos hacia S3, no para distribución de contenido.','dificil'),
(3,'¿Qué protocolo de routing usa Amazon Route 53 para conectar DNS con alta disponibilidad?','OSPF','BGP','Anycast a nivel global con múltiples servidores DNS autoritativos distribuidos','RIP','C','Route 53 usa Anycast a nivel global: hay múltiples servidores DNS distribuidos en ubicaciones de borde por todo el mundo. Las consultas DNS se dirigen automáticamente al servidor más cercano, garantizando baja latencia y alta disponibilidad.','dificil'),
(3,'¿Cuántas zonas de disponibilidad tiene típicamente una región de AWS?','1-2','2-3','3-6','10 o más','C','La mayoría de las regiones AWS tienen entre 3 y 6 zonas de disponibilidad, aunque el mínimo para nuevas regiones es 3. Cada AZ es independiente con su propia infraestructura de energía, refrigeración y redes.','medio'),
(3,'¿Qué servicio de AWS permite conectar redes corporativas a AWS de forma dedicada con anchos de banda de 1 Gbps a 100 Gbps?','AWS Site-to-Site VPN','AWS Direct Connect','AWS Transit Gateway','Amazon CloudFront','B','AWS Direct Connect proporciona una conexión dedicada y privada desde instalaciones locales a AWS. Ofrece mayor ancho de banda (1-100 Gbps), latencia más consistente y menor costo de transferencia que conexiones por internet.','medio'),
(3,'¿Qué es una tabla de rutas en Amazon VPC?','Un registro DNS','Un conjunto de reglas que determina hacia dónde se dirige el tráfico de red de una subred','Un tipo de Security Group','Un registro de auditoría de red','B','Una tabla de rutas contiene reglas (rutas) que determinan hacia dónde se dirige el tráfico de red. Cada subred debe estar asociada a una tabla de rutas. La tabla de rutas principal se crea automáticamente con la VPC.','medio'),
(3,'¿Qué es un VPC Endpoint?','Un punto de acceso externo a la VPC','Un punto de conexión que permite acceder a servicios AWS de forma privada sin atravesar internet','Un tipo de gateway de VPN','Una dirección IP elástica','B','Los VPC Endpoints permiten conectarse a servicios AWS de forma privada sin exponer el tráfico a internet. Hay dos tipos: Interface Endpoints (basados en PrivateLink) y Gateway Endpoints (para S3 y DynamoDB).','dificil'),
(3,'¿Qué es Amazon API Gateway y cómo se relaciona con AWS Lambda?','Es un servicio DNS que enruta a funciones Lambda','Es un servicio que permite crear APIs que invocan funciones Lambda (y otros backends) para construir aplicaciones serverless','Es un servicio de balanceo de carga para Lambda','Es una alternativa a Lambda','B','API Gateway actúa como la "puerta delantera" para aplicaciones serverless. Recibe solicitudes HTTP, las dirige a funciones Lambda (u otros backends) y devuelve las respuestas, formando el núcleo de arquitecturas serverless.','medio'),
(3,'¿Qué servicio de AWS proporciona conectividad de red global usando la red privada de fibra de AWS?','Amazon CloudFront','AWS Global Accelerator','Amazon Route 53','AWS Direct Connect','B','AWS Global Accelerator mejora la disponibilidad y el rendimiento de aplicaciones usando la red global de AWS. El tráfico entra a la red AWS en el punto de presencia más cercano y viaja por la red privada de fibra hasta la aplicación.','dificil'),
(3,'¿Qué es el modelo de VPC con subredes públicas y privadas?','Una arquitectura de seguridad donde los servidores web están en subredes públicas y las bases de datos en subredes privadas, separando capas de la aplicación','Una configuración de VPN entre dos VPCs','Un tipo de peering de VPC','Una configuración de Multi-AZ','A','La arquitectura típica de 2 o 3 niveles coloca los servidores web/ALB en subredes públicas (con acceso a internet) y las bases de datos y servidores de aplicación en subredes privadas (sin acceso directo a internet).','medio'),
(3,'¿Qué protocolo usa el balanceo de carga de capa 7 (Application Load Balancer)?','TCP/UDP','HTTP/HTTPS y WebSocket','SMTP','FTP','B','El Application Load Balancer (ALB) opera en la capa 7 del modelo OSI y soporta los protocolos HTTP, HTTPS y WebSocket. Puede enrutar tráfico basándose en URL, cabeceras HTTP, métodos y otros atributos de la solicitud.','medio'),
(3,'¿Qué es AWS Transit Gateway Connect?','Una conexión a internet de alta velocidad','Una función que permite conectar appliances SD-WAN y de red de terceros a Transit Gateway usando GRE','Un tipo de VPN clientless','Un servicio de CDN','B','Transit Gateway Connect simplifica la integración de appliances SD-WAN de terceros con AWS Transit Gateway mediante túneles GRE y protocolos BGP, eliminando la necesidad de tunneling basado en IPSec.','dificil'),
(3,'¿Cuál es el beneficio principal de usar Elastic Load Balancing con Auto Scaling?','Reducir costos de DNS','Distribuir el tráfico entre instancias sanas y escalar automáticamente según la demanda, garantizando alta disponibilidad','Cifrar el tráfico entre instancias','Gestionar certificados SSL','B','ELB distribuye el tráfico solo a instancias saludables (mediante health checks) y funciona con Auto Scaling para añadir o eliminar instancias según la carga. Juntos garantizan alta disponibilidad y escalabilidad.','medio'),
(3,'¿Qué permite hacer la característica de sticky sessions en un Load Balancer?','Mejorar la velocidad de respuesta','Vincular las solicitudes de un usuario a la misma instancia de backend durante una sesión','Cifrar las sesiones de usuario','Comprimir el tráfico HTTP','B','Las sticky sessions (o session affinity) vinculan las solicitudes de un usuario específico a la misma instancia de backend usando una cookie. Son útiles para aplicaciones con estado que almacenan datos de sesión localmente.','dificil'),
(3,'¿Qué es Amazon VPC Flow Logs?','Registros de tráfico HTTP','Una función que captura información sobre el tráfico IP hacia y desde interfaces de red en una VPC','Un servicio de monitorización de DNS','Un tipo de tabla de rutas','B','VPC Flow Logs captura información sobre el tráfico IP que fluye hacia y desde interfaces de red, subredes o VPCs completas. Los logs se pueden enviar a CloudWatch Logs o S3 para análisis de seguridad y diagnóstico.','medio'),

-- MÓDULO 4 ADICIONALES (18 más → total 40)
(4,'¿Qué es una política (policy) de AWS IAM?','Un conjunto de usuarios con los mismos permisos','Un documento JSON que define permisos de acceso a recursos AWS','Un tipo de rol de IAM','Una regla de firewall','B','Las políticas de IAM son documentos JSON que definen qué acciones están permitidas o denegadas sobre qué recursos AWS y bajo qué condiciones. Se adjuntan a identidades (usuarios, grupos, roles) o recursos.','facil'),
(4,'¿Qué diferencia hay entre una política gestionada por AWS y una política gestionada por el cliente?','No hay diferencia','Las políticas gestionadas por AWS son creadas y mantenidas por AWS; las del cliente son creadas y gestionadas por el usuario para sus necesidades específicas','Las políticas del cliente son más seguras','Las políticas de AWS son gratuitas, las del cliente tienen costo','B','AWS Managed Policies son políticas predefinidas por AWS para casos de uso comunes. Customer Managed Policies son creadas por el usuario, ofreciendo mayor granularidad y control sobre los permisos específicos de la organización.','medio'),
(4,'¿Qué es AWS Single Sign-On (AWS SSO / IAM Identity Center)?','Un servicio de inicio de sesión único que permite gestionar el acceso a múltiples cuentas AWS y aplicaciones desde un lugar central','Un tipo de autenticación de dos factores','Un servicio de directorio LDAP','Un tipo de política IAM','A','AWS IAM Identity Center (sucesor de AWS SSO) permite gestionar el acceso SSO a múltiples cuentas AWS y aplicaciones de negocio. Los usuarios pueden iniciar sesión con sus credenciales corporativas y acceder a todos los recursos asignados.','medio'),
(4,'¿Cuándo deberías usar roles de IAM en lugar de usuarios de IAM?','Siempre que sea posible, especialmente para servicios AWS y aplicaciones','Solo para usuarios humanos','Solo para aplicaciones externas a AWS','Nunca, los usuarios son más seguros','A','Los roles de IAM son preferibles a los usuarios de IAM para: servicios AWS (EC2, Lambda), aplicaciones en instancias EC2, federación de identidades y acceso entre cuentas. No tienen credenciales estáticas, lo que es más seguro.','medio'),
(4,'¿Qué es la rotación automática de secretos en AWS Secrets Manager?','Cambiar la contraseña del usuario root','Actualizar automáticamente las credenciales de bases de datos u otros secretos sin interrupción del servicio','Rotar las claves de cifrado de KMS','Cambiar los certificados SSL periódicamente','B','Secrets Manager puede rotar automáticamente las credenciales de RDS, Redshift, DocumentDB y otros servicios. La rotación es transparente: la aplicación siempre obtiene las credenciales actuales del secreto.','dificil'),
(4,'¿Qué servicio de AWS proporciona evaluación de conformidad continua de los recursos AWS?','AWS CloudTrail','AWS Config','Amazon GuardDuty','AWS Trusted Advisor','B','AWS Config registra continuamente los cambios de configuración de los recursos AWS y evalúa estos cambios contra las reglas de conformidad definidas. Permite ver el historial completo de configuración de cualquier recurso.','medio'),
(4,'¿Qué es AWS Detective?','Un servicio de detección de intrusos de red','Un servicio que analiza, investiga y visualiza datos de seguridad para identificar la causa raíz de problemas de seguridad','Un servicio de auditoría de código','Un tipo de política de seguridad','B','Amazon Detective analiza automáticamente datos de CloudTrail, VPC Flow Logs y GuardDuty para crear un modelo unificado e interactivo basado en gráficos. Facilita investigaciones de seguridad y análisis de causa raíz.','dificil'),
(4,'¿Qué certificación de conformidad garantiza que AWS protege adecuadamente los datos de tarjetas de pago?','HIPAA','SOC 2','PCI DSS','ISO 27001','C','PCI DSS (Payment Card Industry Data Security Standard) es el estándar de seguridad para organizaciones que manejan datos de tarjetas de crédito. AWS tiene certificación PCI DSS Nivel 1 para muchos de sus servicios.','dificil'),
(4,'¿Qué es el cifrado en tránsito (encryption in transit) en AWS?','Cifrar datos mientras se guardan en disco','Cifrar datos mientras se transfieren entre sistemas usando TLS/SSL','Cifrar backups de datos','Cifrar claves de cifrado','B','El cifrado en tránsito protege los datos mientras se mueven entre sistemas usando protocolos como TLS 1.2+. AWS lo soporta para todos sus servicios, garantizando que los datos no puedan interceptarse durante la transmisión.','medio'),
(4,'¿Qué es el cifrado en reposo (encryption at rest) en AWS?','Cifrar datos durante la transferencia','Cifrar datos cuando están almacenados en disco, usando servicios como AWS KMS','Cifrar código de aplicación','Cifrar logs de CloudTrail','B','El cifrado en reposo protege los datos almacenados. AWS KMS gestiona las claves de cifrado para S3, EBS, RDS, DynamoDB y otros servicios. Los datos se cifran automáticamente antes de guardarse en disco.','medio'),
(4,'¿Qué servicio de AWS permite centralizar y automatizar las respuestas a hallazgos de seguridad?','Amazon GuardDuty','AWS Security Hub','Amazon Inspector','AWS Config','B','AWS Security Hub agrega hallazgos de seguridad de GuardDuty, Inspector, Macie y otros servicios en un panel central. Permite priorizar y automatizar respuestas a amenazas de seguridad en toda la organización.','dificil'),
(4,'¿Qué es una AWS Organizations Service Control Policy (SCP)?','Una política de costos','Una política que define los permisos máximos disponibles para todas las cuentas de una unidad organizativa','Un tipo de política IAM para usuarios','Una regla de firewall de red','B','Las SCPs definen los límites máximos de permisos para cuentas y OUs en AWS Organizations. Incluso si un usuario tiene permisos de administrador en su cuenta, las SCPs pueden restringir qué acciones puede realizar.','dificil'),
(4,'¿Qué herramienta de AWS permite evaluar la seguridad de aplicaciones web buscando vulnerabilidades?','Amazon Inspector','AWS WAF','Amazon GuardDuty','AWS Trusted Advisor','A','Amazon Inspector evalúa automáticamente las aplicaciones en busca de vulnerabilidades o desviaciones de las mejores prácticas. Para aplicaciones web, analiza configuraciones, vulnerabilidades conocidas (CVEs) y exposición de red.','medio'),
(4,'¿Qué es la federación de identidades (Identity Federation) en AWS?','Compartir usuarios IAM entre cuentas','Permitir que usuarios de sistemas de identidad externos (Active Directory, Google) accedan a AWS sin crear usuarios IAM','Un tipo de MFA avanzado','Un servicio de directorio empresarial','B','La federación de identidades permite que los usuarios ya autenticados en sistemas externos (Active Directory, SAML IdPs) accedan a AWS asumiendo roles IAM. Elimina la necesidad de crear usuarios IAM para cada empleado.','dificil'),
(4,'¿Qué estándar soporta AWS para la federación de identidades empresariales?','OAuth 1.0','SAML 2.0','OpenID Connect y SAML 2.0','Kerberos únicamente','C','AWS soporta tanto SAML 2.0 (para federación con proveedores empresariales como Active Directory Federation Services) como OpenID Connect/OAuth 2.0 (para proveedores sociales como Google, Amazon, Facebook).','dificil'),
(4,'¿Cuál es el impacto de habilitar AWS CloudTrail en la seguridad de la cuenta?','Aumenta los costos significativamente sin beneficio','Proporciona auditoría completa de todas las llamadas API, mejorando la visibilidad y el cumplimiento','Reduce el rendimiento de los servicios','Reemplaza la necesidad de IAM','B','CloudTrail registra quién hizo qué, cuándo y desde dónde en la cuenta AWS. Esto es fundamental para auditorías de seguridad, investigación de incidentes y cumplimiento de normativas como SOC, PCI y HIPAA.','medio'),
(4,'¿Qué es AWS Firewall Manager?','Un servicio de gestión de reglas de Security Groups','Un servicio que permite gestionar centralmente reglas de WAF, Shield Advanced, Security Groups y Network Firewall en múltiples cuentas','Un tipo de NACL avanzado','Un servicio de IDS/IPS','B','AWS Firewall Manager simplifica la administración y el mantenimiento de reglas de WAF, Shield Advanced, VPC Security Groups, Network Firewall y Route 53 Resolver DNS Firewall en múltiples cuentas y recursos.','dificil'),
(4,'¿Qué protocolo usa AWS para el cifrado de datos en tránsito en la mayoría de sus servicios?','SSL 3.0','TLS 1.0','TLS 1.2 y TLS 1.3','HTTP básico','C','AWS utiliza TLS (Transport Layer Security) versión 1.2 y 1.3 para el cifrado de datos en tránsito. Las versiones antiguas (SSL, TLS 1.0 y 1.1) están deshabilitadas por defecto en los servicios de AWS.','medio'),
(4,'¿Qué componente de IAM permite agrupar usuarios y gestionar sus permisos colectivamente?','IAM Role','IAM Group','IAM Policy','IAM Identity Provider','B','Los grupos de IAM son colecciones de usuarios IAM. En lugar de asignar permisos a cada usuario individualmente, se asignan a grupos. Los usuarios heredan todos los permisos del grupo al que pertenecen.','facil'),

-- MÓDULO 5 ADICIONALES (9 más → total 40)
(5,'¿Qué servicio de AWS es un panel de control visual de costos con alertas automáticas?','AWS Cost Explorer','AWS Budgets con alertas de CloudWatch','AWS Pricing Calculator','AWS Cost and Usage Report','B','AWS Budgets permite crear presupuestos de costo y uso. Cuando el gasto supera (o se prevé que supere) el umbral, envía alertas por email o SNS. También puede ejecutar acciones automáticas como aplicar políticas IAM.','medio'),
(5,'¿Qué es el pilar de "Excelencia Operacional" del AWS Well-Architected Framework?','Optimizar costos de la infraestructura','Ejecutar y monitorizar sistemas para entregar valor de negocio, mejorando continuamente procesos y procedimientos','Proteger los sistemas de ataques externos','Escalar recursos según la demanda','B','La Excelencia Operacional se centra en ejecutar y monitorizar sistemas para entregar valor empresarial. Incluye principios como realizar pequeños cambios frecuentes, anticipar fallos, y aprender de los errores operativos.','medio'),
(5,'¿Qué es el pilar de "Fiabilidad" del AWS Well-Architected Framework?','Minimizar costos de infraestructura','La capacidad de recuperarse de fallos de infraestructura o servicio y cumplir con los requisitos de disponibilidad','Proteger los datos de acceso no autorizado','Optimizar el rendimiento del sistema','B','La Fiabilidad asegura que los sistemas funcionen correctamente y de forma consistente. Incluye principios como probar los procedimientos de recuperación, escalar horizontalmente y recuperarse automáticamente de los fallos.','medio'),
(5,'¿Cuáles son los tres modelos de precios principales de AWS?','Mensual, anual y por demanda','On-Demand (pago por uso), Savings Plans/Reservados (compromiso), y Spot (capacidad no utilizada)','Básico, estándar y premium','Por instancia, por storage y por transferencia','B','Los tres principales modelos de precios de EC2 son: On-Demand (sin compromiso, pago por hora/segundo), Savings Plans/Reservados (compromiso 1-3 años, hasta 72% descuento) y Spot (capacidad sobrante, hasta 90% descuento con posibles interrupciones).','facil'),
(5,'¿Qué es el programa AWS Partner Network (APN)?','Un programa de afiliados de marketing','Un programa global de socios para empresas que usan AWS para construir soluciones y servicios para clientes','Un programa de certificación para desarrolladores','Un programa de startups de AWS','B','AWS Partner Network (APN) es el programa de socios tecnológicos y de consultoría de AWS. Los socios APN (Technology Partners y Consulting Partners) tienen acceso a recursos, capacitación y soporte de AWS para servir a sus clientes.','dificil'),
(5,'¿Qué factor NO afecta el precio de Amazon EC2?','Tipo de instancia','Región de AWS','Modelo de precios (On-Demand, Spot, Reserved)','El sistema operativo del desarrollador que gestiona la instancia','D','Los factores que afectan el precio de EC2 incluyen: tipo de instancia, región, SO (Windows es más caro que Linux), modelo de precios y transferencia de datos saliente. El SO del administrador no tiene relevancia.','medio'),
(5,'¿Qué es AWS Trusted Advisor y cuántos checks incluye el plan Business?','Una herramienta de análisis de código con 5 checks','Una herramienta de mejores prácticas con más de 400 checks en planes Business/Enterprise','Un servicio de consultoría manual con 10 checks','Una herramienta de facturación con 15 checks','B','Trusted Advisor evalúa el entorno AWS con checks en: optimización de costos, rendimiento, seguridad, tolerancia a fallos y límites de servicio. Los planes Basic y Developer tienen 7 checks; Business y Enterprise tienen acceso completo a más de 400 checks.','medio'),
(5,'¿Qué herramienta de AWS permite modelar y aprovisionar infraestructura como código (IaC)?','AWS CLI','AWS CloudFormation','AWS Config','AWS Systems Manager','B','AWS CloudFormation permite definir la infraestructura usando plantillas JSON o YAML. CloudFormation aprovisiona y gestiona los recursos automáticamente, permitiendo versionar la infraestructura igual que el código de aplicación.','medio'),
(5,'¿Cuáles son los planes de soporte de AWS de menor a mayor coste?','Free, Basic, Standard, Enterprise','Basic, Developer, Business, Enterprise On-Ramp, Enterprise','Starter, Professional, Business, Enterprise','Free, Standard, Advanced, Enterprise','B','Los planes de soporte de AWS son: Basic (gratuito), Developer (mínimo técnico), Business (producción), Enterprise On-Ramp (negocios críticos, TAM compartido) y Enterprise (misión crítica, TAM dedicado). Cada nivel incluye tiempos de respuesta más rápidos y más funcionalidades.','facil');

-- ─── PREGUNTAS DE ESCENARIO (infraestructura global y responsabilidad compartida) ────
INSERT INTO preguntas (modulo_id, pregunta, opcion_a, opcion_b, opcion_c, opcion_d, respuesta_correcta, explicacion, dificultad) VALUES

(5, 'Una startup tecnológica necesita diseñar una infraestructura resiliente y escalable en AWS para gestionar el aumento del tráfico y garantizar alta disponibilidad. ¿Qué afirmación describe MEJOR el beneficio de alta disponibilidad que proporciona la infraestructura global de AWS?',
'AWS centraliza todos los datos del cliente en un único bucket S3 de alta redundancia para simplificar la administración y garantizar la disponibilidad del servicio.',
'AWS opera múltiples centros de datos distribuidos en diferentes regiones geográficas, de modo que el servicio puede seguir activo aunque una ubicación falle.',
'AWS ofrece un único centro de datos de alto rendimiento capaz de gestionar cualquier nivel de tráfico y garantizar la disponibilidad continua del servicio.',
'AWS proporciona múltiples canales de soporte disponibles las 24 horas para resolver incidentes de forma inmediata y garantizar la continuidad del negocio.',
'B', 'AWS opera múltiples regiones y Zonas de Disponibilidad en todo el mundo. Esta distribución geográfica mejora la alta disponibilidad al garantizar que si una ubicación tiene problemas, otras pueden asumir el tráfico sin interrupciones. Es el pilar de Fiabilidad del Well-Architected Framework.', 'facil'),

(4, 'Una startup está desarrollando una aplicación en la nube y hay una nueva actualización de seguridad disponible para el sistema operativo de sus instancias EC2. ¿Quién es responsable de aplicar los parches de seguridad al sistema operativo que se ejecuta en la nube?',
'AWS gestiona y aplica automáticamente todos los parches de seguridad al sistema operativo de las instancias EC2 sin intervención del cliente.',
'Tanto AWS como el cliente aplican parches de forma independiente: AWS parchea el kernel y el cliente gestiona el resto del entorno del sistema operativo.',
'El proveedor del sistema operativo (Microsoft, Red Hat, etc.) distribuye e instala automáticamente todos los parches de seguridad necesarios en las instancias.',
'El cliente es el responsable de gestionar las actualizaciones y parches de seguridad del sistema operativo que se ejecuta en sus instancias EC2.',
'D', 'Según el Modelo de Responsabilidad Compartida, el cliente es responsable de la seguridad "en" la nube: esto incluye el sistema operativo invitado, sus parches, la configuración del firewall de la instancia y los datos. AWS gestiona la seguridad "de" la nube (hardware, red, hipervisor).', 'medio'),

(5, 'Un equipo de desarrollo quiere explicar el modelo cliente-servidor al resto de la empresa y cómo encaja la computación en la nube en él. ¿Qué afirmación describe MEJOR el modelo cliente-servidor y su relación con la computación en la nube?',
'El cliente envía solicitudes al servidor, que las procesa y devuelve las respuestas. La computación en la nube proporciona recursos de servidor escalables a los que se puede acceder a través de internet.',
'El modelo cliente-servidor está desactualizado y la computación en la nube lo ha reemplazado completamente por un modelo de procesamiento distribuido sin distinción de roles.',
'En el modelo cliente-servidor el servidor solo almacena datos y el cliente realiza todo el procesamiento; la nube aporta únicamente capacidad de almacenamiento adicional.',
'En el modelo cliente-servidor el cliente protege sus datos y el servidor protege el hardware físico; la computación en la nube introduce un tercer modelo que los sustituye.',
'A', 'El modelo cliente-servidor es la base de la computación en red: el cliente hace peticiones y el servidor las procesa y responde. La computación en la nube extiende este modelo ofreciendo servidores virtuales escalables y flexibles en AWS, accesibles desde cualquier lugar a través de internet.', 'facil'),

(5, 'Una empresa quiere desplegar recursos en varias ubicaciones de AWS para lograr alta disponibilidad. ¿Qué afirmación describe MEJOR la diferencia entre las regiones y las zonas de disponibilidad (AZ) de AWS?',
'Una zona de disponibilidad abarca múltiples ubicaciones físicas repartidas entre las regiones, siendo las regiones las unidades de despliegue de menor tamaño en la infraestructura global.',
'Una región es un único centro de datos de alta seguridad, y una zona de disponibilidad agrupa varios de estos centros de datos dentro de la misma instalación física compartida.',
'Una región es una ubicación geográfica que contiene tres o más zonas de disponibilidad; cada zona es una ubicación diferenciada con uno o más centros de datos independientes.',
'Una zona de disponibilidad contiene tres o más regiones, y cada región dispone de uno o más centros de datos con alimentación eléctrica y conectividad de red propias.',
'C', 'Una Región AWS es un área geográfica (ej: eu-west-1, us-east-1) con 2 o más AZs. Cada Availability Zone consta de uno o más data centers físicamente separados, con alimentación, refrigeración y red independientes, lo que garantiza que un fallo en una AZ no afecte a las demás.', 'facil'),

(4, 'Una empresa financiera que migra a la nube se pregunta si necesitará personal para proteger la infraestructura física de los recursos de computación en la nube de AWS. ¿Qué afirmación describe MEJOR su responsabilidad sobre la protección de la infraestructura física?',
'La empresa comparte con AWS la responsabilidad de proteger físicamente los centros de datos, aportando personal de seguridad para las instalaciones donde residen sus recursos.',
'AWS es responsable de proteger la infraestructura física de sus centros de datos, y la empresa puede centrarse en proteger sus datos y aplicaciones en la nube.',
'La empresa asume la responsabilidad total de proteger la infraestructura física de la nube, incluyendo los centros de datos, el hardware y el cableado de red de AWS.',
'La empresa no tiene ninguna responsabilidad de seguridad en la nube, ya que AWS gestiona íntegramente todos los aspectos de seguridad, tanto físicos como lógicos.',
'B', 'Según el Modelo de Responsabilidad Compartida, AWS es responsable de la seguridad "de" la nube: protección física de los data centers (controles de acceso, vigilancia, climatización, hardware). El cliente es responsable de la seguridad "en" la nube: datos, cifrado, IAM y configuración de servicios.', 'facil'),

(5, 'Una empresa lanzará una aplicación web global en AWS. ¿Qué beneficios proporciona DIRECTAMENTE la infraestructura global de AWS al distribuir recursos en múltiples ubicaciones geográficas?',
'Alta disponibilidad y tolerancia a errores, ya que si un centro de datos o región falla, los recursos en otras ubicaciones geográficas mantienen el servicio operativo.',
'Facilidad de uso y conformidad normativa, gracias a las consolas de gestión simplificadas y las certificaciones de cumplimiento disponibles en todas las regiones de AWS.',
'Reducción de costes y simplicidad de administración, al consolidar todos los recursos de la aplicación en un único punto de presencia global optimizado por AWS.',
'Cumplimiento normativo y ahorro en licencias de software, al eliminar la necesidad de mantener centros de datos físicos propios con personal de TI especializado.',
'A', 'La infraestructura global de AWS distribuye recursos en múltiples regiones y AZs, lo que aporta: (1) Alta disponibilidad: el sistema sigue operativo aunque falle una ubicación. (2) Tolerancia a errores: los sistemas redundantes en distintas AZs minimizan el tiempo de inactividad. Estos son beneficios directos de la distribución geográfica.', 'medio');

-- ─── PREGUNTAS DE ESCENARIO: MODELOS DE DESPLIEGUE Y BENEFICIOS DE LA NUBE ─
INSERT INTO preguntas (modulo_id, pregunta, opcion_a, opcion_b, opcion_c, opcion_d, respuesta_correcta, explicacion, dificultad) VALUES

(5, 'Un organismo gubernamental quiere mantener control total sobre su infraestructura de las TI, pero planea usar servicios de AWS para aplicaciones específicas. ¿Qué tipo de despliegue es MÁS ADECUADO para esta situación?',
'Despliegue en la nube pública: toda la infraestructura se ejecuta en AWS sin mantener servidores físicos propios ni centros de datos locales.',
'Despliegue multi-nube: la infraestructura se distribuye entre varios proveedores de nube pública para evitar la dependencia de un único proveedor.',
'Despliegue local (on-premises): toda la infraestructura se mantiene en las instalaciones propias de la organización, sin usar ningún servicio de nube pública.',
'Despliegue híbrido: se combinan los sistemas locales con servicios de AWS, permitiendo mantener el control sobre la infraestructura crítica y usar la nube para otras aplicaciones.',
'D', 'El despliegue híbrido combina infraestructura local con servicios en la nube pública. Es la solución ideal para organismos que necesitan control total sobre sus sistemas críticos (on-premises) mientras aprovechan la escalabilidad y los servicios gestionados de AWS para otras cargas de trabajo.', 'facil'),

(5, 'Una gran empresa busca reducir los costes operativos y la sobrecarga asociada con la administración de su propia infraestructura física. ¿Cuál de estas opciones describe MEJOR el beneficio que la nube ofrece a esta empresa?',
'Aumentar la velocidad y la agilidad, desplegando nuevos recursos tecnológicos en minutos en lugar de esperar semanas o meses para aprovisionar hardware.',
'Dejar de hacer conjeturas sobre la capacidad necesaria, aprovisionando únicamente los recursos que la demanda real requiere en cada momento del año.',
'Beneficiarse de las grandes economías de escala que AWS logra al agregar la demanda de cientos de miles de clientes de todo el mundo.',
'Dejar de gastar dinero en ejecutar y mantener centros de datos físicos propios, liberándose de la responsabilidad operativa del hardware y las instalaciones.',
'D', 'Uno de los seis beneficios clave del cloud computing es dejar de gastar dinero en ejecutar y mantener centros de datos. Al migrar a AWS, la empresa elimina los costes de hardware, refrigeración, seguridad física y personal de operaciones del data center, reduciendo drásticamente la sobrecarga operativa.', 'facil'),

(5, 'El director financiero de una pequeña empresa le preocupan los costes fijos al considerar migrar su infraestructura a la nube. ¿Qué afirmación define con PRECISIÓN la computación en la nube y aborda directamente esa preocupación?',
'La computación en la nube reduce la necesidad de hardware adicional, pero las suscripciones a los servicios conllevan tarifas mensuales fijas similares a las de un centro de datos propio.',
'La computación en la nube es la entrega bajo demanda de recursos de las TI a través de internet con precios de pago por uso, lo que reduce los costes fijos y permite presupuestos más flexibles.',
'La computación en la nube implica la adquisición de servidores específicos y la configuración de un centro de datos privado, con costes fijos de hardware, licencias y mantenimiento.',
'La computación en la nube consiste en usar los servidores de otro proveedor para alojar aplicaciones, sin ofrecer ventajas de coste significativas frente a las soluciones de alojamiento tradicionales.',
'B', 'La computación en la nube se define como la entrega bajo demanda de recursos de las TI a través de internet con precios de pago por uso (pay-as-you-go). Este modelo elimina la necesidad de grandes inversiones iniciales en hardware (CAPEX) y sustituye los costes fijos por costes variables (OPEX), resolviendo directamente la preocupación del director financiero.', 'facil'),

(4, 'Según el Modelo de Responsabilidad Compartida de AWS, ¿cuál de las siguientes es una responsabilidad del CLIENTE y NO de AWS?',
'Garantizar la seguridad física de los centros de datos donde se ejecuta la infraestructura de AWS a nivel global.',
'Mantener el hardware físico de los servidores y actualizar el software de los servicios gestionados de computación, red y almacenamiento.',
'Aplicar los parches de seguridad al sistema operativo de las instancias EC2 y gestionar el cifrado de los datos del lado del cliente.',
'Administrar la red global de fibra óptica de AWS y la infraestructura de hipervisores que soporta los servicios de virtualización.',
'C', 'En el Modelo de Responsabilidad Compartida: el CLIENTE es responsable de la seguridad "en" la nube, lo que incluye parchear el SO invitado de sus instancias EC2, implementar cifrado de datos del lado del cliente y gestionar IAM. AWS es responsable de la seguridad "de" la nube: hardware, instalaciones físicas, red global e hipervisores.', 'medio');
