#dazi


Dazi is a filetype-plugin for GraphViz *.dot files that adds a command for viewing the png output of the current buffer.

GraphViz must be installed in order for your system to have the ``dot`` command.

For linux, you need feh to be the image viewer component. On windows, you need python3 with tkinter to view the images.

It adds one command:

    :Dazi

...By default it also adds one normal-mode mapping.

``<F7>`` for running the viewer command.

global ``dazimap`` to the key you want

    let g:dazimap = '<blah>'



