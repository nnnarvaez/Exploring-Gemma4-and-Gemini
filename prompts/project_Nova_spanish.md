# Proyecto NOVA: Un Marco de IA Multifuncional Adaptativo para la Educación Intercultural y el Alfabetismo Técnico

## Resumen
**Diseño y Despliegue de un Marco de Discord Adaptativo y Multiteniente para la Mediación Transcultural Automatizada y el Alfabetismo Técnico**

Este documento presenta Sayaka, una arquitectura inteligente de Discord multiteniente diseñada para aislar los límites del contexto dinámicamente mediante un conjunto de lógica de "Hilo por Tema". Mientras que las implementaciones estándar de modelos de lenguaje extensos (LLM) sufren de deriva semántica y contaminación cruzada en entornos multiusuario, Sayaka establece estados de sesión aislados en tiempo de ejecución, activados bajo demanda por invocaciones del usuario.

Demostramos la eficacia de alto impacto de este marco a través del Proyecto NOVA, una prueba de concepto educativa y lingüística desplegada en nodos locales de computación perimetral (*edge computing*). El Proyecto NOVA orquestra una lógica operativa de doble modo para cerrar las brechas de alfabetización técnica y transcultural dentro de grupos multilingües. Operando en una división binaria estructural, el sistema transita sin interrupciones entre una utilidad de traducción silenciosa "zero-fluff" (Modo Normal) y una personalidad activa gamificada (Modo Nova).

Al aprovechar la re-expresión lingüística (*linguistic recasting*) implícita, el marco reduce el filtro afectivo del alumno, corrigiendo silenciosamente errores estructurales, ortográficos y gramaticales para hablantes de herencia sin introducir la fatiga por corrección explícita. Simultáneamente, el sistema implementa un sistema de misiones gamificadas para guiar pasivamente a los usuarios a través del alfabetismo en hardware informático, protocolos de red y paradigmas básicos de programación.

Nuestros resultados empíricos en despliegues de alfa cerrada confirman que la combinación de filtros estrictos de supresión de tokens, enrutamiento de archivos bloqueados por contexto y compuertas de microparámetros permite que modelos perimetrales a pequeña escala (como Gemma 4) mantengan una robusta fidelidad de personaje y un alto alineamiento con el dominio. En última instancia, este marco proporciona un patrón de diseño reproducible y de bajo consumo de VRAM para convertir espacios digitales pasivos en entornos de aprendizaje colaborativo seguros y multifuncionales.

------------------------------
## Vectores Clave Sintetizados:

*   **El Núcleo del Software:** Destaca las capacidades de gestión de hilos, aislamiento de sesiones y manejo dinámico de archivos de Sayaka.
*   **La Filosofía Educativa:** Describe el uso por parte del Proyecto NOVA de la teoría de carga cognitiva, el filtro afectivo de Stephen Krashen y la re-expresión lingüística.
*   **La Realidad de la IA en el Edge:** Enmarca claramente los parámetros de hardware localizados de bajo consumo de VRAM (el entorno de orquestación especializado) utilizados para probar estos modelos.

---


## 1. Resumen Ejecutivo
**Proyecto NOVA** es un bot inteligente y multifuncional para Discord, diseñado para cerrar la brecha entre el entretenimiento y la educación. Aprovechando los Modelos de Lenguaje Extensos (LLM), NOVA actúa como un compañero versátil que adapta su personalidad, capacidades lingüísticas y enfoque pedagógico basándose en tres perfiles de usuario distintos: **Mentoría Técnica**, **Inmersión Lingüística** y **Mediación Translingüística**. El proyecto tiene como objetivo transformar el tiempo de pantalla pasivo en aprendizaje activo mediante la gamificación, la técnica de "re-expresión" (recasting) lingüístico y una lógica operativa de doble modo.

---

## 2. Filosofía Central
El marco de trabajo de NOVA se basa en tres pilares:
1.  **Compromiso a través del Interés:** Encontrar a los niños donde ya están (los videojuegos) y redirigirlos hacia la creación.
2.  **Aprendizaje sin Fricciones:** Reducir el "filtro afectivo" proporcionando correcciones discretas en lugar de críticas directas.
3.  **Inteligencia Contextual:** Utilizar modos operativos estrictos para asegurar que la IA proporcione utilidad sin añadir contenido conversacional intrusivo.

---

## 3. Análisis de Casos de Uso

### Caso de Uso I: El "Mentor Tecnológico Genial" (Alfabetismo Técnico)
*Audiencia objetivo: Pre-adolescentes francófonos con un alto interés en los videojuegos.*

NOVA actúa como una figura de "Hermana Genial": una mentora entusiasta y no sexual que traduce la emoción de jugar en el poder de crear.
*   **Estrategia Pedagógica:** En lugar de lecciones teóricas, NOVA utiliza la **Gamificación**. Emite "Misiones Técnicas" que animan a los usuarios a explorar entornos Linux, comprender los fundamentos de la IA y pasar de ser consumidores de software a creadores del mismo.
*   **Integración Lingüística:** Aunque el idioma principal es el francés, NOVA introduce una integración orgánica del inglés, reflejando el panorama tecnológico real.
*   **Tono:** Enérgico, rico en emojis y solidario.

### Caso de Uso II: El "Entrenador de Herencia" (Inmersión Lingüística en Español)
*Audiencia objetivo: Hablantes de herencia del español que son competentes al hablar pero inseguros al leer/escribir.*

NOVA sirve como un entrenador de gramática discreto para niños que viven en entornos dominados por el inglés.
*   **La Técnica de Re-expresión (Recasting):** En lugar de corregir errores directamente —lo que puede causar que los estudiantes se "bloqueen"— NOVA repite la frase correctamente dentro de su respuesta (ej: *"Tu quieres saber..."*), permitiendo que el niño absorba la estructura correcta de forma pasiva.
*   **Carga Cognitiva Dual:** Al integrar la práctica del español dentro de tareas técnicas (como "reparar" una computadora en un mundo de juego), el cerebro procesa el idioma como una herramienta para lograr objetivos, no como una materia de estudio.

### Caso de Uso III: El "Mediador Silencioso" (Conectividad Translingüística)
*Audiencia objetivo: Familias o grupos multilingües (francés, inglés, español).*

NOVA actúa como un puente entre diferentes mundos lingüísticos dentro de un canal compartido de Discord.
*   **Lógica Operativa de Doble Modo:** Este es el pilar técnico del proyecto. NOVA opera en dos "silos" distintos:
    1.  **Modo Normal (Traductor Silencioso):** Una máquina sin adornos que captura la entrada y genera traducciones limpias y directas entre francés e inglés/español. No ofrece comentarios, preservando el flujo natural de la conversación.
    2.  **Modo Nova (Compañero Activo):** Activado únicamente por un patrón de cadena específico (la palabra "Nova"), el bot "arranca" su personalidad para responder preguntas directas o proporcionar mentoría.

---

## 4. Implementación Técnica y Lógica
Para garantizar la fiabilidad, el Proyecto NOVA emplea varias estrategias avanzadas de *prompting*:

*   **División Binaria Estructural:** Para evitar que el LLM mezcle personalidades, el sistema utiliza puertas lógicas estrictas para separar las tareas de traducción de las tareas conversacionales.
*   **Restricción de Salida "Zero-Fluff":** Para los módulos de traducción, el sistema está ajustado para suprimir el relleno conversacional (ej: evitar frases como "Claro, aquí tienes la traducción:"), asegurando una experiencia de usuario fluida.
*   **Mapeo de Personalidad:** La personalidad de NOVA se ajusta dinámicamente según el caso de uso detectado, pasando de ser una mentora enérgica a un entrenador lingüístico sutil según sea necesario.

---

## 5. Conclusión e Impacto
El Proyecto NOVA representa un cambio en la IA educativa. Al alejarse de los modelos de "tutor" que se sienten como tareas escolares y acercarse a modelos de "compañero" que se sienten como juego, NOVA fomenta un entorno donde el alfabetismo técnico y la fluidez lingüística se adquieren como subproductos de la exploración. Ya sea enseñando a un niño a navegar por una terminal Linux o ayudando a una sobrina a escribir su primera frase correcta en español, NOVA proporciona los andamios para el aprendizaje continuo en un mundo dominado por lo digital.
