JSON Trie Dictionary, 0.0 alpha
===============================
>Note: Some features descripted here
>have **not** been implemented yet.

These scripts allows the user to save many
provided words and "compress" them into
[*tries*](http://en.wikipedia.org/wiki/Trie).

The `generate.rb` script takes a list of words 
from a text file to construct a trie dictionary.
Finally, it serializes the trie into JSON and
copies it into a `*.json` file.

The `dict_interpreter.rb` script contains a
class which constructor takes the `*json` file
produced by the previouly descripted script.
This class contains multiple look-up operations
for the dictionary.

An example
----------
If this only the `ca` word is contained
in the input file, then this will be
the output file as a JSON trie
(without format):

	{ "c" : { "a" : { "end" : true },
	      "end" : false
	    },
	  "end" : false
	}

If you add the word `catch`, you will get:

	{ "c" : { "a" : { "end" : true,
	          "t" : { "c" : { "end" : false,
	                  "h" : { "end" : true }
	                },
	              "end" : false
	            }
	        },
	      "end" : false
	    },
	  "end" : false
	}

**Summarizing**, each generated JSON dictionary
trie contains many independent characters that
may or may not be an end for a word.

Formatting JSON tries
---------------------
The JSON dictionary trie is sopposed to
be interpreted by another program instead
of being useful in any way to be readed by
anyone. That's the reason it's not formatted.

You can format it using a tool like
[this one](http://jsonformat.com/).