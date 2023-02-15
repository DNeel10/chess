# Checkmate
## conditions for checkmate:
### while a king is in check
#### a king has no valid moves to get out of check (this will be accomplished through the #would_be_in_check / #valid_moves method in the king class)
#### a player has no moves that block check
##### how will it know this part? Can something look at all pieces to update valid moves?


# board display
## currently board only shows the value of a cell
## need to implement a "cell" class that holds:
### the coordinates that the cell is in
### the piece that is on those coordinates
### the background color of the cell


# Game flow
## white player moves first, then black
