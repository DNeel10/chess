# create a pieces class that generates/composes all pieces needed by a player
## should return an array of pieces, which can be used in a Player object

# implement check
## king will need a method of "in_check" 
## player cannot make a move when in check unless the move removes check (either blocking with another piece, or moving king)
## player needs a flag for whether or not they are in check
## if a move puts the opponent in check, the opponents flag needs to change
## 

# potential moves for each piece
## need each piece to have its own potential moves that follow the move pattern that it started with
### for example: if a rook moves up ([1, 0]), then the next move in the same pattern can only use the up pattern also ([2, 0] vs. [0, 1])