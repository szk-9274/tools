from pynput import mouse

print("=== クリック座標取得デモ ===")
print("左クリックすると、その座標を表示します")
print("終了するには Ctrl + C を押してください\n")

def on_click(x, y, button, pressed):
    if pressed and button == mouse.Button.left:
        print(f"Clicked at: X={x}, Y={y}")

with mouse.Listener(on_click=on_click) as listener:
    listener.join()
