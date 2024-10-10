clear
clc
clf

a = arduino();
sensor = mpu6050(a);

headings = ["Welcome to Pong!","Select Game Difficulty: "];
options = ["Easy","Hard (Not for the faint of heart)"];
UI0 = menu("Pong","Singleplayer (vs Computer)");
if UI0 == 1
    UI = menu(headings,options);
end
%Creates a UI 

BallVel = [1,1]; %Sets velocity of ball
BallPos = [50,50]; %Sets position of ball

global blockA %Global variable allows me to call this into the keyboard press function
global blockB
blockA = 50; %Sets a centre for block A
blockB = 50; %Sets a centre for block B
%Template used global variables and apparently program only works by using
%it. Maybe because of the usage of "KeyPressFcn"

if UI == 1
    pongFig = figure('color','w', 'KeyPressFcn', @myFun); 
    pongAxes = axes('color', 'k','XColor','w','YColor','w', 'Xlim',[0 100], 'Ylim',[0 100]);
    set(gca,'XTick',[],'Ytick',[])
    %Produces figure and axes

    ballSize = 30; 
    paddleSize = 10; %Creates a "paddle"
    pongBall = line(BallPos(1),BallPos(2),'marker','.','markersize', ballSize, 'color', 'w');
    pongBlockA = line([blockA - paddleSize blockA + paddleSize],[3 3], 'linewidth', 4, 'color', 'w'); %Creates player block
    pongBlockB = line([blockB - paddleSize blockB + paddleSize],[97 97], 'linewidth', 4, 'color', 'w'); 
elseif UI == 2
    BallVel = [2,2]; %Doubled velocity for hard mode
    pongFig = figure('color','w', 'KeyPressFcn', @myFun);
    pongAxes = axes('color', 'k','XColor','w','YColor','w', 'Xlim',[0 100], 'Ylim',[0 100]);
    set(gca,'XTick',[],'Ytick',[])

    ballSize = 30;
    paddleSize = 10;
    pongBall = line(BallPos(1),BallPos(2),'marker','.','markersize', ballSize, 'color', 'w');
    pongBlockA = line([blockA - paddleSize blockA + paddleSize],[3 3], 'linewidth', 4, 'color', 'w'); 
    pongBlockB = line([blockB - paddleSize blockB + paddleSize],[97 97], 'linewidth', 4, 'color', 'w'); 
end

A = 0; 
B = 0; 
text(50,50, ' : ','color','w');
%Initialises score and text for it

tic
while toc < 600 %Sets a timer for 10 minutes
    accel = readAcceleration(sensor);
    x_accel = accel(:,1);
    %Gets the accelerometer data for the x-axis

    sens = 10; %Used to adjust sensitivity for the accelerometer
    blockA = blockA + (sens*x_accel);
    blockA = max(min(blockA, 100 - paddleSize),paddleSize); %Makes sure block A stays within game bounds

    if BallPos(2) > 95 %If the ball meets the enemy paddle
        if abs(BallPos(1) - blockB) < paddleSize %If the ball hits the paddle
            BallVel(2) = -BallVel(2); %Ball bounces off the paddle
        else
            A = A + 1; %Player A scores
            BallPos = [50,50]; 
            BallVel(2) = -BallVel(2); 
        end
    end
    
    if BallPos(2) < 5 %If the ball meets your paddle
        if abs(BallPos(1) - blockA) < paddleSize 
            BallVel(2) = -BallVel(2);
        else
            B = B + 1; %Player B scores
            BallPos = [50,50]; 
            BallVel(2) = -BallVel(2);
        end   
    end
      
    if BallPos(1) < 0 || BallPos(1) > 100 %If the ball hits the top or bottom
        BallVel(1) = -BallVel(1);
    end
        
    BallPos = BallPos + BallVel; %Changes ball position ("Moving")
    set(pongBall, 'XData',BallPos(1),'YData',BallPos(2)) %Sets coordinates for the ball
    set(pongBlockA, 'XData', [blockA - paddleSize, blockA + paddleSize]) %Sets player block
    set(pongBlockB, 'XData', [blockB - paddleSize, blockB + paddleSize])
    
       
    if blockA > 110 || blockA < -10 %If paddle goes out of bounds
        blockA = 50; %Reset paddle position
    end

    if blockB > 110 || blockB < -10
        blockB = 50;
    end

    if UI == 1 || UI == 2 
        if BallPos(1) >= blockB
            blockB = blockB + 1.5;
        elseif BallPos(1) < blockB
            blockB = blockB - 1.5;
        end
    end
    %This section allows the "computer" to track the ball movement based on
    %where it goes
    
    scoreText = text(37,60,"Score 3 points to win",'color','w');
    aText = text(45,50, {num2str(A)},'color','w'); 
    bText = text(55,50, {num2str(B)},'color','w');
    pause(0.02); 
    delete(aText); 
    delete(bText);  

    if A == 3
        headings1 = ["Congratulations! You have won!","Choose option: "];
        options1 = ["Replay","Quit"];
        UI1 = menu(headings1,options1);
        if UI1 == 1
            run Pongv2_1.m
        elseif UI1 == 2
            close
        end
    elseif B == 3
        headings2 = ["Sucks to suck, loser", "You really want to play again?"];
        options2 = ["Bruise your ego again","Give up"];
        UI2 = menu(headings2,options2);
        if UI2 == 1
            run Pongv2_1.m
        elseif UI2 == 2
            close
        end
    end
    %Creates extra UI components for replaying and quitting

end

function myFun(~,event) %Provides keyboard usage
global blockA
global blockB

switch event.Key
    case 'leftarrow'
        blockA = blockA - 10;
    case 'rightarrow'
        blockA = blockA + 10;
end
end