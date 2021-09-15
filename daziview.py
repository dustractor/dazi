import tkinter as tk
import argparse
import subprocess
import pathlib
import os

args = argparse.ArgumentParser()
args.add_argument("thefile")
ns = args.parse_args()

class Application(tk.Tk):

    def __init__(self):
        super().__init__()
        q = lambda _:self.quit()
        self.bind("q",q)
        self.bind("<Escape>",q)
        self.bind("<Control-[>",q)
        self.bind("<Control-c>",q)
        self.bind("<Double-Button-1>",self.reveal_image)
        self.bind("<Key-space>",self.reveal_image)
        self.img = tk.PhotoImage(file=ns.thefile)
        self.label = tk.Label(self,image=self.img)
        self.label.pack()

    def reveal_image(self,*e):
        subprocess.run('explorer /select,"%s"'%ns.thefile)


if __name__ == '__main__':
    gui = Application()
    gui.mainloop()

