import pyautogui
import random
import time
import keyboard
import sys

pyautogui.FAILSAFE = True
pyautogui.MINIMUM_DURATION = 0.1
INTERVALO_SHIFT = 60  # Segundos entre cada pulsación de Shift
proxima_pulsacion = time.time() + INTERVALO_SHIFT

# --- ANIMACIÓN DE CUENTA ATRÁS ---
print("PREPARANDO MOTORES...")
segundos = 10
for i in range(segundos * 10, -1, -1):
    # Cuando i es 0, porcentaje = (1 - 0) * 100 = 100
    porcentaje = (1 - i/(segundos*10)) * 100
    barra = "█" * int(porcentaje / 5) + "-" * (20 - int(porcentaje / 5))
    
    sys.stdout.write(f"\rArrancando en: {i/10:.1f}s |{barra}| {int(porcentaje)}%")
    sys.stdout.flush()
    time.sleep(0.1)

print("\n\n🚀 ¡A MOVERSE!")
print("🎯 Haz clic en esta ventana y pulsa la tecla 'ESC' varias veces para parar")

try:
    while True:
        # Presiona y suelta Shift solo si ha pasado 1 minuto (no escribe nada ni abre menús)
        tiempo_actual = time.time()
        if tiempo_actual >= proxima_pulsacion:
            pyautogui.press('shift')
            print(f"[{time.strftime('%H:%M:%S')}] ⚡ Shift pulsado (Refresco de sesión)")
            proxima_pulsacion = tiempo_actual + INTERVALO_SHIFT
        
        if keyboard.is_pressed('esc'):
            break
            
        ancho, alto = pyautogui.size()
        
        # Elegimos un destino aleatorio
        x = random.randint(100, ancho - 100)
        y = random.randint(100, alto - 100)
        
        # Tweens: Hacen que el ratón acelere y frene (como una mano de verdad)
        # Opciones: easeInQuad, easeOutQuad, easeInOutSine
        pyautogui.moveTo(x, y, duration=random.uniform(0.5, 3.5), tween=pyautogui.easeInOutQuad)
        # 2. SE DETIENE Y HACE CLICK
        pyautogui.click()
        print(f"[{time.strftime('%H:%M:%S')}] 🖱️ Click en ({x}, {y})")
        
        # Pausa aleatoria para no parecer un bot
        time.sleep(random.uniform(1, 3))

    print("\n🛑 Programa finalizado por el usuario.")

except Exception as e:
    print(f"\nTerminado: {e}")
