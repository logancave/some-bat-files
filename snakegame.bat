@echo off
title Snake Game
setlocal EnableDelayedExpansion

:: Initialize game variables
set "width=20"
set "height=10"
set "snake_length=3"
set "score=0"
set "game_over=false"

:: Create the game field
for /L %%y in (1,1,%height%) do (
    for /L %%x in (1,1,%width%) do (
        set "field[%%x,%%y]=."
    )
)

:: Initial snake position
set /a "snake_x=5"
set /a "snake_y=5"
set /a "food_x=10"
set /a "food_y=5"

:: Main game loop
:gameLoop
if "%game_over%"=="true" goto endGame

:: Display game field
cls
for /L %%y in (1,1,%height%) do (
    for /L %%x in (1,1,%width%) do (
        set /p "=", <nul
        if %%x==%snake_x% if %%y==%snake_y% (
            set "char=S"
        ) else if %%x==%food_x% if %%y==%food_y% (
            set "char=F"
        ) else (
            set "char=!field[%%x,%%y]!"
        )
        echo|set /p=!char!
    )
    echo.
)

:: Handle input (W, A, S, D for movement)
set /p "key=Press W/A/S/D to move: "
if "%key%"=="W" set /a "snake_y-=1"
if "%key%"=="S" set /a "snake_y+=1"
if "%key%"=="A" set /a "snake_x-=1"
if "%key%"=="D" set /a "snake_x+=1"

:: Check if the snake has eaten the food
if "%snake_x%"=="%food_x%" if "%snake_y%"=="%food_y%" (
    set /a "score+=1"
    set /a "food_x=%random% %% %width% + 1"
    set /a "food_y=%random% %% %height% + 1"
)

:: Check for collisions with the walls
if "%snake_x%" lss 1 set "game_over=true"
if "%snake_x%" gtr %width% set "game_over=true"
if "%snake_y%" lss 1 set "game_over=true"
if "%snake_y%" gtr %height% set "game_over=true"

:: Delay to make the game playable
ping -n 2 127.0.0.1 >nul
goto gameLoop

:endGame
echo Game Over! Your score was %score%.
pause
