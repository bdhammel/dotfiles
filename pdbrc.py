import pdb
import readline
from pathlib import Path

IRRELEVANT_HISTORY = set([ 
    'n', 'l', 'll', 'l.', 's', 'r', 'c', None
])

class Config(pdb.DefaultConfig):

    def setup(self, pdb):
        # Save history across sessions
        histfile_path = Path("~/.pdb-pyhist").expanduser()

        try:
            readline.read_history_file(histfile_path)
        except IOError:
            pass

        import atexit
        atexit.register(self.clean_history)
        atexit.register(readline.write_history_file, histfile_path)
        readline.set_history_length(500)

    def clean_history(self):
        history_len = readline.get_current_history_length()
        cleaned_history = []
        for history_idx in range(history_len): 
            history_item = readline.get_history_item(history_idx) 
            if history_item not in IRRELEVANT_HISTORY:
                cleaned_history.append(history_item)
        readline.clear_history()
        for history in cleaned_history:
            readline.add_history(history)


def hist():
    y = range(readline.get_current_history_length() + 2)
    print(*[readline.get_history_item(x) for x in y], sep='\n')
