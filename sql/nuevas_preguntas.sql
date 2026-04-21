-- Nuevas preguntas AWS CLF-C02 / CLF-C01
-- Las respuestas correctas están distribuidas entre A, B, C y D de forma aleatoria
-- ya que el código hace shuffle adicional al mostrarlas al usuario.

SET NAMES utf8mb4;

-- ─── MÓDULO 1: COMPUTACIÓN ─────────────────────────────────────────────────
INSERT INTO preguntas (modulo_id, pregunta, opcion_a, opcion_b, opcion_c, opcion_d, respuesta_correcta, explicacion, dificultad) VALUES

(1, 'Una empresa quiere migrar una aplicación crítica a AWS. La aplicación tiene un tiempo de ejecución corto y se invoca por cambios en datos o estados del sistema. La empresa necesita la solución de cómputo que maximice la eficiencia operacional y minimice el costo. ¿Qué solución de AWS debe utilizar?',
'Amazon EC2 On-Demand',
'Amazon EC2 Reserved Instances',
'AWS Lambda',
'Amazon EC2 Spot Instances',
'C', 'AWS Lambda es la solución serverless ideal: ejecuta código en respuesta a eventos sin gestionar servidores, con duración máxima de 15 minutos y pago por invocación+milisegundos de ejecución. Maximiza la eficiencia operacional al eliminar la gestión de infraestructura.', 'facil'),

(1, '¿Por qué AWS es más económico que los centros de datos tradicionales para aplicaciones con cargas de trabajo variables?',
'Las instancias de Amazon EC2 pueden lanzarse bajo demanda cuando sea necesario',
'Los costos de Amazon EC2 se facturan de forma mensual',
'Los usuarios mantienen acceso administrativo total a sus instancias EC2',
'Los usuarios pueden ejecutar de forma permanente instancias suficientes para los picos',
'A', 'Con EC2 On-Demand, pagas solo cuando usas los recursos y los terminas cuando no los necesitas. Esto evita sobreprovisionar para picos de carga, reduciendo el costo total frente a data centers donde debes comprar hardware para el máximo esperado.', 'facil'),

(1, '¿Qué responsabilidades tiene una empresa que utiliza AWS Lambda? (Elige la más representativa)',
'Selección de recursos de CPU para las funciones',
'Parcheo del sistema operativo subyacente',
'Escritura y actualización del código de la función',
'Seguridad de la infraestructura subyacente',
'C', 'En AWS Lambda (modelo serverless), el cliente es responsable de escribir, actualizar y asegurar el código de la función y los datos que procesa. AWS gestiona la infraestructura, el sistema operativo, el parcheo y el escalado automáticamente.', 'medio'),

(1, '¿Cuál de los siguientes servicios AWS puede usarse como solución de recuperación ante desastres para instancias Amazon EC2?',
'EC2 Reserved Instances',
'AWS Shield',
'Amazon Elastic Block Store (Amazon EBS) Snapshots',
'Amazon GuardDuty',
'C', 'Los snapshots de EBS crean copias de seguridad incrementales de los volúmenes de disco de las instancias EC2. Se almacenan en S3 y se pueden usar para restaurar volúmenes en caso de desastre. Las AMIs son otra opción válida para disaster recovery.', 'medio');

-- ─── MÓDULO 2: ALMACENAMIENTO Y BASES DE DATOS ─────────────────────────────
INSERT INTO preguntas (modulo_id, pregunta, opcion_a, opcion_b, opcion_c, opcion_d, respuesta_correcta, explicacion, dificultad) VALUES

(2, 'Una empresa planea crear un data lake que utiliza Amazon S3. ¿Qué factor tendrá el mayor efecto en el costo?',
'La adición de políticas de bucket S3',
'Las tarifas de ingesta de S3 por cada solicitud',
'Los cargos por transferir datos existentes a Amazon S3',
'La selección de clases de almacenamiento S3',
'D', 'Las clases de almacenamiento de S3 (Standard, Intelligent-Tiering, Standard-IA, Glacier, etc.) tienen precios muy diferentes. Elegir la clase adecuada para el patrón de acceso es el factor más impactante en el costo. La ingesta a S3 es gratuita; se cobra el almacenamiento y las recuperaciones.', 'medio'),

(2, '¿Qué producto de AWS simplificaría la migración de una base de datos a AWS?',
'AWS Storage Gateway',
'AWS Database Migration Service (AWS DMS)',
'Amazon EC2',
'Amazon AppStream 2.0',
'B', 'AWS DMS (Database Migration Service) migra bases de datos hacia AWS con mínimo tiempo de inactividad. La base de datos fuente permanece operativa durante la migración. Soporta migraciones homogéneas (MySQL→MySQL) y heterogéneas (Oracle→Aurora con AWS SCT).', 'facil');

-- ─── MÓDULO 3: REDES Y ENTREGA DE CONTENIDO ────────────────────────────────
INSERT INTO preguntas (modulo_id, pregunta, opcion_a, opcion_b, opcion_c, opcion_d, respuesta_correcta, explicacion, dificultad) VALUES

(3, 'Una empresa está planeando ejecutar una aplicación de marketing global en AWS con videos que deben visualizarse con baja latencia para todos los usuarios. ¿Qué servicio de AWS debe utilizar?',
'Amazon CloudFront',
'AWS Auto Scaling',
'Elastic Load Balancing',
'Amazon Kinesis Video Streams',
'A', 'Amazon CloudFront es la CDN (Red de Distribución de Contenido) de AWS con más de 400 ubicaciones de borde en todo el mundo. Almacena el contenido en caché cerca de los usuarios finales para reducir la latencia, siendo la solución ideal para distribución global de videos.', 'facil'),

(3, '¿Qué componente de la infraestructura global de AWS está formado por uno o más centros de datos discretos con alimentación eléctrica, red y conectividad redundantes?',
'AWS Region',
'Availability Zone',
'Edge location',
'AWS Outposts',
'B', 'Una Availability Zone (AZ) consiste en uno o más centros de datos físicamente separados dentro de una Región, con alimentación, refrigeración y redes redundantes e independientes. Esta separación física protege ante fallos localizados.', 'facil'),

(3, '¿Qué producto de redes de AWS permite a una empresa crear una red virtual dentro de AWS?',
'AWS Config',
'Amazon Route 53',
'AWS Direct Connect',
'Amazon Virtual Private Cloud (Amazon VPC)',
'D', 'Amazon VPC (Virtual Private Cloud) permite crear una red virtual privada y aislada dentro de la nube AWS. Tienes control total sobre el rango de IPs, subredes, tablas de rutas, gateways y configuración de red, similar a una red tradicional en tu propio data center.', 'facil'),

(3, '¿Qué componente de la infraestructura global de AWS utiliza Amazon CloudFront para garantizar una entrega con baja latencia?',
'Ubicaciones de borde (Edge Locations)',
'Regiones de AWS',
'Zonas de Disponibilidad',
'Virtual Private Cloud (VPC)',
'A', 'CloudFront utiliza su red de más de 400 Edge Locations (ubicaciones de borde / Points of Presence) repartidas por 90+ ciudades en todo el mundo. Estas ubicaciones almacenan el contenido en caché cerca de los usuarios finales para minimizar la latencia.', 'facil');

-- ─── MÓDULO 4: SEGURIDAD, IDENTIDAD Y CUMPLIMIENTO ─────────────────────────
INSERT INTO preguntas (modulo_id, pregunta, opcion_a, opcion_b, opcion_c, opcion_d, respuesta_correcta, explicacion, dificultad) VALUES

(4, 'Una gran empresa tiene múltiples departamentos, cada uno con su propia cuenta AWS y Instancias Reservadas de EC2. Algunos departamentos no usan todas sus Reserved Instances y otros necesitan más de las que compraron. ¿Qué servicio debe usar la empresa para compartir las Reserved Instances?',
'AWS Organizations',
'AWS Systems Manager',
'Cost Explorer',
'AWS Trusted Advisor',
'A', 'AWS Organizations permite gestionar múltiples cuentas de forma centralizada. Con la facturación consolidada, las Reserved Instances y Savings Plans no utilizados en una cuenta pueden aplicar automáticamente descuentos a otras cuentas de la misma organización.', 'medio'),

(4, '¿Cuál de las siguientes es una responsabilidad de AWS según el modelo de responsabilidad compartida?',
'Configuración de aplicaciones de terceros',
'Mantenimiento del hardware físico',
'Protección del acceso a la aplicación y sus datos',
'Administración de sistemas operativos invitados',
'B', 'En el Modelo de Responsabilidad Compartida, AWS es responsable de la seguridad "de" la nube: hardware físico, instalaciones, red global e infraestructura subyacente. Los clientes son responsables de la seguridad "en" la nube: SO invitado, aplicaciones, datos y configuraciones.', 'facil'),

(4, '¿Cómo puede el administrador del sistema añadir una capa de seguridad adicional durante el inicio de sesión en la consola de AWS?',
'Mediante Amazon Cloud Directory',
'Por medio de una auditoría de los roles de AWS IAM',
'Mediante la habilitación de la autenticación multifactor (MFA)',
'Mediante la habilitación de AWS CloudTrail',
'C', 'La autenticación multifactor (MFA) añade una segunda capa de seguridad al inicio de sesión. Además de contraseña, el usuario necesita un código temporal de una app autenticadora (Google Authenticator, Authy, etc.) o un dispositivo hardware MFA. Es especialmente crítica para la cuenta root.', 'facil'),

(4, '¿Qué servicio puede identificar al usuario que realizó una llamada a la API cuando una instancia EC2 fue terminada?',
'AWS Trusted Advisor',
'AWS X-Ray',
'AWS Identity and Access Management (AWS IAM)',
'AWS CloudTrail',
'D', 'AWS CloudTrail registra todas las llamadas a la API de AWS, incluyendo quién realizó la acción (usuario IAM, rol, cuenta), cuándo, desde qué IP y con qué parámetros. Es esencial para auditoría, investigación forense y cumplimiento normativo.', 'facil'),

(4, '¿Qué documentación proporciona AWS Artifact?',
'Certificaciones ISO de AWS',
'Términos y condiciones de Amazon EC2',
'Historial del gasto de la empresa en AWS',
'Lista de tipos de instancias EC2 de generaciones anteriores',
'A', 'AWS Artifact es un portal de autoservicio para descargar informes de conformidad y auditoría de AWS: certificaciones ISO 27001, informes SOC 1/2/3, documentos PCI DSS, HIPAA BAA y más. El acceso es gratuito e inmediato desde la consola de AWS.', 'medio'),

(4, '¿Qué tarea requiere el uso de las credenciales del usuario root de la cuenta AWS?',
'Ver información de facturación',
'Iniciar y detener instancias Amazon EC2',
'Cambiar el plan de AWS Support',
'Abrir un caso de AWS Support',
'C', 'Cambiar el plan de AWS Support es una de las pocas tareas que solo puede realizar el usuario root de la cuenta. Otras tareas exclusivas del root incluyen: cerrar la cuenta, cambiar el email de la cuenta, activar IAM access a billing, y restaurar permisos de administrador IAM.', 'dificil'),

(4, '¿Dónde puede encontrar un usuario información sobre las acciones prohibidas en la infraestructura de AWS?',
'Política de uso aceptable de AWS',
'AWS Trusted Advisor',
'AWS Identity and Access Management (IAM)',
'Consola de facturación de AWS',
'A', 'La Política de Uso Aceptable de AWS (AWS Acceptable Use Policy) define lo que está permitido y prohibido en la infraestructura AWS, incluyendo actividades ilegales, envío de spam, ataques DDoS y otros abusos. Está disponible públicamente en aws.amazon.com/aup.', 'facil');

-- ─── MÓDULO 5: FACTURACIÓN, PRECIOS Y ARQUITECTURA ─────────────────────────
INSERT INTO preguntas (modulo_id, pregunta, opcion_a, opcion_b, opcion_c, opcion_d, respuesta_correcta, explicacion, dificultad) VALUES

(5, '¿A qué pilar del Well-Architected Framework hace referencia la capacidad de un sistema para recuperarse de interrupciones de infraestructura y adquirir dinámicamente recursos de cómputo para satisfacer la demanda?',
'Seguridad',
'Eficiencia de Rendimiento',
'Fiabilidad (Reliability)',
'Optimización de Costos',
'C', 'El pilar de Fiabilidad (Reliability) se centra en la capacidad de un sistema de recuperarse automáticamente de fallos, cumplir la demanda y mitigar interrupciones. Incluye diseño para fallos, escalado dinámico, backups y pruebas de recuperación.', 'facil'),

(5, 'Una empresa planea reemplazar sus servidores físicos on-premises con servicios serverless de AWS para aprovechar tecnologías avanzadas rápidamente tras la migración. ¿Qué pilar del Well-Architected Framework representa este plan?',
'Seguridad',
'Fiabilidad',
'Optimización de Costos',
'Eficiencia de Rendimiento',
'D', 'El pilar de Eficiencia de Rendimiento trata sobre el uso eficiente de recursos de cómputo para satisfacer requisitos del sistema. Incluye experimentar con nuevas tecnologías (como serverless) y tener presencia global para reducir latencia, eliminando la carga operativa de gestionar hardware.', 'medio'),

(5, 'Un usuario quiere revisar los costos mensuales de Amazon EC2 y Amazon RDS del último año. ¿Qué servicio o herramienta de AWS proporciona esta información?',
'Cost Explorer',
'AWS Trusted Advisor',
'Amazon Forecast',
'Amazon CloudWatch',
'A', 'AWS Cost Explorer proporciona visualizaciones interactivas del costo y uso de AWS con hasta 12 meses de datos históricos. Permite filtrar por servicio (EC2, RDS), cuenta, región o etiqueta, y también genera previsiones de gasto futuro.', 'facil'),

(5, 'Una empresa lanza una aplicación de e-commerce que debe estar siempre disponible y correrá en EC2 continuamente los próximos 12 meses. ¿Cuál es la opción de compra más rentable?',
'Spot Instances',
'Dedicated Hosts',
'Savings Plans',
'On-Demand Instances',
'C', 'Los Savings Plans ofrecen hasta 72% de descuento sobre On-Demand comprometiéndose a un gasto $/hora durante 1 o 3 años. Para una aplicación que corre continuamente 12 meses, esta opción es mucho más económica que On-Demand. Spot Instances no son válidas porque la aplicación no puede interrumpirse.', 'medio'),

(5, '¿Qué servicio o función de AWS puede usar una empresa para determinar qué unidad de negocio utiliza recursos AWS específicos?',
'Cost Allocation Tags',
'Amazon Inspector',
'Key pairs',
'AWS Trusted Advisor',
'A', 'Las Cost Allocation Tags son etiquetas clave-valor que se añaden a los recursos AWS (EC2, S3, RDS…). Una vez activadas en Billing, aparecen en Cost Explorer y los reportes de costos, permitiendo desglosar el gasto por departamento, proyecto, equipo o entorno.', 'medio'),

(5, 'Una empresa quiere migrar sus cargas de trabajo a AWS pero carece de experiencia en cloud computing. ¿Qué servicio o función de AWS les ayudará con la migración?',
'AWS Consulting Partners',
'AWS Managed Services',
'AWS Trusted Advisor',
'AWS Artifacts',
'B', 'AWS Managed Services (AMS) proporciona servicios de gestión de operaciones de infraestructura en AWS para empresas que carecen del expertise necesario. AMS gestiona el entorno AWS según las mejores prácticas de seguridad y operaciones, permitiendo al cliente centrarse en el negocio.', 'medio'),

(5, '¿Qué servicio o herramienta de AWS debe usar una empresa para solicitar y rastrear de forma centralizada los aumentos de límites de servicio?',
'AWS Config',
'AWS Service Catalog',
'AWS Budgets',
'Service Quotas',
'D', 'AWS Service Quotas (antes llamado Service Limits) es el servicio centralizado para ver y solicitar aumentos de cuotas de todos los servicios AWS desde un único lugar. Permite rastrear el estado de las solicitudes y configurar alarmas de CloudWatch cuando te aproximas al límite.', 'medio'),

(5, 'Un usuario está comparando opciones de compra para una aplicación en EC2 y RDS que no puede tolerar interrupciones. El uso es predecible con picos estacionales de pocas semanas. No es posible modificar la aplicación. ¿Qué opción es ÓPTIMA en costo?',
'Comprar Reserved Instances + permitir los picos estacionales en On-Demand',
'Revisar AWS Marketplace y comprar Partial Upfront Reserved Instances para toda la carga',
'Comprar Reserved Instances + permitir los picos estacionales en Spot Instances',
'Comprar Reserved Instances para cubrir todo el uso potencial incluyendo los picos',
'A', 'La estrategia óptima es: comprar Reserved Instances para la carga base predecible (descuento de hasta 72%) y dejar que los picos estacionales corran en On-Demand. No se pueden usar Spot Instances porque la aplicación no puede interrumpirse. Comprar Reserved para los picos sería demasiado costoso.', 'dificil'),

(5, '¿Qué servicio o función de AWS permite a los usuarios conectarse y desplegar servicios AWS de forma programática?',
'AWS Management Console',
'AWS software development kits (SDKs)',
'AWS Cloud9',
'AWS CodePipeline',
'B', 'Los AWS SDKs (Software Development Kits) permiten interactuar programáticamente con los servicios AWS desde tu código usando lenguajes como Python (boto3), JavaScript, Java, Go, .NET, PHP y más. Son la forma estándar de integrar AWS en aplicaciones.', 'facil'),

(5, '¿Cuál es el beneficio de migrar a la nube AWS que mejor describe la capacidad de escalar rápidamente ante picos de demanda y de desplegar globalmente en minutos?',
'Eliminación de la necesidad de auditorías de seguridad',
'Eliminación del costo del personal de TI',
'Redundancia por defecto para todos los servicios de cómputo',
'Agilidad empresarial y alcance global',
'D', 'La agilidad empresarial es una ventaja clave de AWS: permite responder rápidamente a cambios de negocio, experimentar con bajo riesgo y desplegar recursos globalmente en minutos. Esto incluye escalar ante picos de demanda y expandirse a nuevas regiones geográficas con facilidad.', 'medio'),

(5, '¿Qué tipo de despliegue en la nube describe una situación en la que una organización mantiene recursos locales para cumplimiento de datos y usa recursos en la nube pública para el escalado dinámico ante picos de demanda?',
'Despliegue local (on-premises)',
'Despliegue en la nube pública',
'Despliegue de conformidad de datos',
'Despliegue híbrido',
'D', 'El despliegue híbrido combina infraestructura on-premises con recursos de nube pública. Es ideal cuando existen requisitos de residencia de datos (que obligan a mantener ciertos datos localmente) pero se necesita la flexibilidad y escalabilidad de la nube pública para gestionar picos de demanda.', 'facil'),

(5, '¿Qué oferta de AWS permite a los usuarios encontrar, comprar y comenzar a usar de forma inmediata soluciones de software en su entorno de AWS?',
'AWS Config',
'AWS OpsWorks',
'AWS Marketplace',
'AWS SDK',
'C', 'AWS Marketplace es una tienda digital con miles de productos de software de terceros (AMIs, SaaS, contenedores, modelos de ML) listos para desplegarse en tu cuenta AWS con un clic. La facturación se integra directamente en tu factura de AWS.', 'facil'),

(5, '¿Qué servicio de AWS se usaría para enviar alertas basadas en alarmas de Amazon CloudWatch?',
'AWS CloudTrail',
'Amazon Route 53',
'Amazon Simple Notification Service (Amazon SNS)',
'AWS Trusted Advisor',
'C', 'Amazon SNS (Simple Notification Service) se integra de forma nativa con CloudWatch Alarms. Cuando una métrica supera un umbral, la alarma de CloudWatch puede publicar en un topic de SNS, que a su vez envía notificaciones a suscriptores (email, SMS, Lambda, SQS, etc.).', 'facil');
