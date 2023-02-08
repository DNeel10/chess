# implement checkfinder class
## will king need a method of "in_check" or will the player need it?
### player cannot make a move when in check unless the move removes check (either blocking with another piece, or moving king)
#### when does check finder look for check to know if a piece blocks check or not?

# Checkmate
## need to build win conditions:
### a king is in check, and a player has no valid moves to remove check

# King Moves
## anything else need to be done here? 

# updating valid_moves
## pieces will need to have their valid moves updated each time a player moves a piece to account for pieces blocking potential moves
### this could also tie into check/check mate

# how do i manage the "active_pieces" array in each player class?
## this could allow for easier move updates

# Game flow
## white player moves first, then black
