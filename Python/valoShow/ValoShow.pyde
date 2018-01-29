add_library('tui')

def setup():
    fullScreen()
    #size(400, 400)
    TUI.aloita(this)
    
def draw():
    frameRate(60)
    #DefaultWhite
    background(255)
    #BlackScreen Spacebar
    if (TUI.nappain_painettu(32)):
        background(0, 0, 0)
    #Rainbow [1-7]
    if (TUI.nappain_painettu(49)):
        background(255, 0, 0)
    if (TUI.nappain_painettu(50)):
        background(255, 102, 0)
    if (TUI.nappain_painettu(51)):
        background(255, 255, 20)
    if (TUI.nappain_painettu(52)):
        background(0, 255, 0)
    if (TUI.nappain_painettu(53)):
        background(20, 255, 255)
    if (TUI.nappain_painettu(54)):
        background(0, 0, 255)
    if (TUI.nappain_painettu(55)):
        background(195, 0, 255)
    #3 Random binds
    if (TUI.nappain_painettu(56)):
        background(0, 202, 255)
    if (TUI.nappain_painettu(57)):
        background(255, 0, 128)
    if (TUI.nappain_painettu(48)):
        frameRate(10)
        background(random(0, 255), random(0, 255), random(0, 255))
        
def keyPressed():
    TUI.huomaa_painallus()
    
def keyReleased():
    TUI.huomaa_vapautus()
