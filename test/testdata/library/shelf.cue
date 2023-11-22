package library

import (
    "examplebooks.com/books",
)

#Shelf: {
	name: string
	"books": [books.#Book, ...books.#Book]
}

shelf: #Shelf