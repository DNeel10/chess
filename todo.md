# implement checkfinder class
## how does check look for
### Checkfinder will need to know where the white and black kings are
#### will need to know for all of a player's pieces, if any of their possible moves include the opponent's king position
#### if any does, return true

## what does in check mean?
### king will need a method of "in_check" 
### player cannot make a move when in check unless the move removes check (either blocking with another piece, or moving king)
### player needs a flag for whether or not they are in check
### if a move puts the opponent in check, the opponents flag needs to change


# Pawn moves
## pawn move pattern is different depending on player's position (bottom of board, or top)
### if white (bottom) pawn can move up 1 (or 2 if first move)
### if black (top) pawn can move -1 (or -2 if first move)
## pawn can attack in a diagonal if capturing a piece

# Game flow
## white player moves first, then black
