with Ada.Text_IO; use Ada.Text_IO;

procedure helloWorld is
    type state is range 0 .. 2; -- 0 is blank, 1 is x, 2 is o
    type index is range 0 .. 2;
    type board is array (index, index) of state;

    gameOver : Boolean;
    gameBoard : board;
    turn : state;
    userInput : String (3 .. 3);
    lineLength : Integer;
    xCoord : index;
    yCoord : index;

    procedure printBoard (currentBoard : board) is
    begin
        Put_Line ("-------------");
        for Y in Index loop
            put ("| ");
            for X in Index loop
                case currentBoard (X, Y) is
                    when 0 => put (" ");
                    when 1 => put ("X");
                    when 2 => put ("O");
                end case;
                put (" | ");
            end loop;
            New_Line;
            Put_Line ("-------------");
        end loop;
    end printBoard;

    function checkWin (currentBoard : board) return Boolean is
    begin
        --check diagonals
        if currentBoard (0,0) = currentBoard (1,1) and currentBoard (1,1) = currentBoard (2,2) and currentBoard (0,0) /= 0 then
            return True;
        end if;

        --check vertical and horrisontal wins
        for indexCounter in Index loop 
            if currentBoard (0,indexCounter) = currentBoard (1,indexCounter) and currentBoard (1,indexCounter) = currentBoard (2,indexCounter) and currentBoard (0,indexCounter) /= 0 then
                return True;
            end if;

            if currentBoard (indexCounter,0) = currentBoard (indexCounter,1) and currentBoard (indexCounter,1) = currentBoard (indexCounter,2) and currentBoard (indexCounter,0) /= 0 then
                return True;
            end if;
        end loop;

        return False;
    end;

begin
    -- initilises the board so all the spaces are blank
    for X in Index loop 
        for Y in Index loop
            gameBoard (X, Y) := 0;
        end loop;
    end loop;

    gameOver := false;
    turn := 1;

    while not gameOver loop
        Put_Line("It is player " & turn'Image & "'s turn");
        Put_Line("Please enter the X coordinate to place your piece ->");
        Ada.Text_IO.Get_Line (userInput, lineLength);
        xCoord := index'Value (userInput);
        Skip_Line; --this is needed so that the next read line statement works correclty and doesnt read what is left over from the previous input

        Put_Line("Please enter the Y coordinate to place your piece ->");
        Ada.Text_IO.Get_Line (userInput, lineLength);
        yCoord := index'Value (userInput);
        Skip_Line;

        if gameBoard(xCoord, yCoord) = 0 then
            gameBoard(xCoord, yCoord) := turn;
        end if;

        printBoard (gameBoard);

        if checkWin(gameBoard) then
            Put_Line("Player " & turn'Image & " wins!");
            return;
        end if;

        if turn = 1 then 
            turn := 2;
        else
            turn := 1;
        end if;

        
    end loop;
end helloWorld;

--use gnatmake to build