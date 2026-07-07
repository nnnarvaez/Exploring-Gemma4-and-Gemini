# 🌸 Sayaka: Tu Espacio de Trabajo de IA Personal
**Un solo bot. Infinitas personalidades. Privacidad total.**

Sayaka es un framework inteligente para Discord diseñado para convertir tu servidor en un centro multifuncional para el aprendizaje, el juego de rol (roleplay) y la interacción especializada con IA. A diferencia de los bots estándar que ofrecen la misma experiencia a todos, **Sayaka te permite crear "salas" privadas con personalidades de IA únicas adaptadas exactamente a lo que quieres hacer.**

***

## ⚙️ Cómo funciona
Sayaka utiliza una lógica de **"Un hilo por tema" (Thread-per-Topic)**. Esto significa que cada vez que inicias una nueva tarea, Sayaka crea un lienzo limpio donde la IA no se confundirá con tus conversaciones anteriores.

1.  **Invocar:** Menciona `@sayaka [tema]` para comenzar.
2.  **Crear:** Sayaka abre instantáneamente un **hilo privado** dedicado exclusivamente a ese tema.
3.  **Personalizar:** ¿Quieres una personalidad específica? Simplemente sube un archivo `SYSTEM_PROMPT.md` al hilo (por ejemplo, "Actúa como un mentor de programación" o "Sé un maestro de mazmorras de fantasía").
4.  **Multitarea:** Puedes tener 10 hilos activos a la vez: uno para aprender Linux, otro para practicar francés y un tercero para rolear con amigos.
5.  **Colaborar:** Invita a tus amigos a estos hilos privados para estudiar juntos en un espacio moderado por IA.

---

## 📚 Proyecto NOVA: Aprendizaje Simplificado
*Nuestro concepto de prueba educativo*

Construimos **NOVA** para mostrar cómo Sayaka puede cerrar la brecha entre aprender un nuevo idioma y dominar la tecnología. Está diseñado para estudiantes que están aprendiendo una segunda lengua mientras intentan comprender conceptos tecnológicos complejos como hardware, programación y redes.

Vive en discord por que los niños y adoslecentes lo usan y estan familiarizados con la interfaz. (Y realmente disocrd es slack para gamers)

**Cómo funciona en la práctica:**
*   **Corrección Invisible:** Si cometes un error gramatical mientras chateas con la IA, esta no te "regañará". En su lugar, repetirá sutilmente tu idea en un lenguaje perfecto y natural (esto se llama *Recasting*). Esto construye tu confianza sin el estrés de ser corregido constantemente.
*   **Aprendizaje Gamificado:** Mientras chateas, la IA te guía a través de "Misiones Tecnológicas": pequeños retos divertidos que te enseñan cómo funcionan las CPU o cómo funciona internet.
*   **Alto Rendimiento:** Optimizado para ejecutarse sin problemas en hardware local (bajo VRAM), haciéndolo accesible para todos.



> **Lee los Libros Blancos (White Papers):**
> * [Versión en Inglés](../prompts/project_Nova_english.md)
> * [Versión en Francés](../prompts/project_Nova_french.md)
> * [Versión en Español](../prompts/project_Nova_spanish.md)


---

## 🤖 Proyecto VERA — el lado agéntico
*Si NOVA es la faceta educativa, **VERA** es donde Sayaka aprendió a actuar, no solo a hablar.*

Sayaka comenzó como una compañera para el aprendizaje y la conexión, y eso sigue siendo su propósito fundamental. El **Proyecto VERA** es el nombre de lo que vino después: las capacidades que le permiten *hacer* cosas por usuarios de confianza, no solo describirlas:

*   **Uso de herramientas (agéntico):** Para una lista de usuarios autorizados, Sayaka puede ejecutar comandos reales, leer y escribir archivos y devolver archivos — puede realmente operar la computadora en la que se ejecuta, no solo describir cómo hacerlo. Lograr que un modelo local de 12B como Gemma4 llame a las herramientas de manera *confiable* significó desenredar algunos conflictos complicados con las plantillas de chat; toda esa batalla está documentada en el informe de dos partes: [Gemma 4 Tool Calling (Parte 1)](../../tutorials/gemma4-tool_call.md) y [Parte 2](../../tutorials/Gemma4_Tool_Calling_2.md).
*   **Tareas programadas (cron):** También puede ejecutar trabajos en un horario determinado por su cuenta — el paso de "responder cuando se le habla" hacia una pequeña autonomía genuina. A propósito, ese es el argumento exacto en [*It Is All Plumbing*](../../lab-notes/it-is-all-plumbing.md): quitando la exageración, un "agente" es realmente solo trabajos cron, subprocesos y fontanería reactiva — que es precisamente lo que hace que sea construible en casa en lugar de ser un misterio que solo los grandes laboratorios pueden vender.

Los límites son deliberados: el acceso a las herramientas está limitado a una lista de ussuarios permitidos y todo lo que hace queda registrado. El objetivo nunca fue entregarle las llaves al modelo, sino darle un conjunto de manos útiles y delimitadas a las personas que deberían tenerlas.

---

## 🧰 La Pila Frugal — la respuesta del ingeniero al hype

Internet te dirá que para ejecutar tu propio asistente de IA necesitas instalar cientos de repositorios e imágenes de Docker, configurar Tailscale y túneles, alquilar un VPS y pagar por un montón de suscripciones: claves API, una API de memoria, todo el conjunto. Ese es el "impuesto del hype".

Sayaka es la respuesta del **Hombre Universal** a eso — el ingeniero que resuelve el problema mediante la ingenio en lugar de un carrito de compras:

*   **Acceso remoto sin túneles ni VPS:** Discord *es* la puerta de enlace. Ya se conecta desde fuera de tu LAN, gratis — así que no hay nada que tunelizar y ningún VPS que alquilar.
*   **El "servidor" es una vieja máquina con Linux.** La cosa por la que todo el mundo alquila un VPS es simplemente una máquina retirada en la esquina.
*   **La inferencia se ejecuta en una PC de juegos.** La GPU que ya posees se encarga del pensamiento.

Nada de esto requiere el circo — y aun así **puede escalar para convertirse en un producto real** si se hace necesario. No lo haces crecer con *este* hardware; solo cambias la capa que importa: alquilas un GPU de **128 GB-VRAM**, y entregale la inferenceia, y tienes una Sayaka para toda una escuela. Puedes administrarla de forma remota con **VERA como KVM** — sus manos y el uso de herramientas se convierten en tu teclado, video y ratón en una máquina que nunca tocas físicamente. El mismo diseño desde casa hasta la escuela; solo pones hardware más potente detrás.

---

## 🎭 Biblioteca de Prompts (Compañeros the chitchat)
¿Quieres probar algo diferente? Inyecta estos prompts en Sayaka para cambiar instantáneamente el ambiente:

| Persona | Descripción | Enlace |
| :--- | :--- | :--- |
| **Jesse Pinkman** | Un personaje de alta fidelidad que habla con la voz y actitud distintivas de Jesse. | [Ver Prompt](../prompts/jessee_pinkman.md) |
| **The Puzo Chronicler** | Una experiencia inmersiva que te transporta al universo cinematográfico de *El Padrino*. | [Ver Prompt](../prompts/the-Puzo-chronicler.md) |

---

## 🚀 ¿Qué viene después?
*   **Agregador de Noticias:** Un hilo dedicado para resumir y discutir noticias en tiempo real.
*   **Memoria Persistente:** Darle a Sayaka una "memoria a largo plazo" para que pueda recordar tus preferencias en diferentes sesiones.

---

### ✨ El Significado de Sayaka
El nombre conlleva dos significados, y ambos son el punto central, construyen la historia (lore).

**La palabra.** En japonés clásico, **Sayaka (清か)** describe algo claro, refrescante o transparente — como el aire de la mañana o una vista brillante y vívida. El objetivo es que la interacción con la IA se sienta exactamente así: clara, refrescante, fácil.

**El personaje.** **Sayaka Yumi**, de *Mazinger Z* — la piloto que luchó junto a Kōji Kabuto y actuó como su equilibrio, inclinando una máquina poderosa y temeraria hacia hacer el bien en lugar de solo causar daño. Ese es el papel para el que fue construida esta Sayaka: no el arma, sino el contrapeso. Y por lo que vale la pena decir, ella es menos un Mecha y más una **Tachikoma** no combatiente — curiosa, habladora, ahí para pensar junto a ti, atravesandose en tu camino tratando de ser útil, no para pelear.

**¿Quieres ayudarnos a construir el futuro?**
¡Contáctame para colaborar o únete a nuestras pruebas alfa cerradas!
