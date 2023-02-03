# implement checkfinder class
## how does check look for
### Checkfinder will need to know where the white and black kings are (each player, or each player's king, gets their own instance of check finder)
#### will need to know for all of a player's king, if any of the opponents pieces moves include the king position
#### if any does, return true

## what does in check mean?
### will king need a method of "in_check" or will the player need it?
### player cannot make a move when in check unless the move removes check (either blocking with another piece, or moving king)
### player needs a flag for whether or not they are in check
### if a move puts the opponent in check, the opponents flag needs to change

# Pawn moves
## pawn move pattern is different depending on player's position (bottom of board, or top)
## pawn can attack in a diagonal if capturing a piece

# King Moves
## king cannot move into check
### valid moves must not include any position that an opponent player's piece is attacking

# updating valid_moves
## pieces will need to have their valid moves updated each time a player moves a piece to account for pieces blocking potential moves

# how do i manage the "active_pieces" array in each player class?
## this could allow for easier move updates

# Game flow
## white player moves first, then black
