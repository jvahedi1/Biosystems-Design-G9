import java.awt.Robot %Imports the Java Robot class
import java.awt.event.*

robot = Robot();

prompt = "What would you like to press: \n"; %Gives an input 
x = input(prompt,"s"); 

%While the input is not "quit", if I type in the letters "wasd", I return
%"ijkl"
while x ~= "quit"
    if x == "a"
        robot.keyPress(java.awt.event.KeyEvent.VK_J)
        robot.keyRelease(java.awt.event.KeyEvent.VK_J)
    elseif x == "d"
        robot.keyPress(java.awt.event.KeyEvent.VK_L)
        robot.keyRelease(java.awt.event.KeyEvent.VK_L)
    elseif x == "w"
        robot.keyPress(java.awt.event.KeyEvent.VK_I)
        robot.keyRelease(java.awt.event.KeyEvent.VK_I)
    elseif x == "s"
        robot.keyPress(java.awt.event.KeyEvent.VK_K)
        robot.keyRelease(java.awt.event.KeyEvent.VK_K)
    end

    pause(1)

    robot.keyPress(java.awt.event.KeyEvent.VK_BACK_SPACE)
    robot.keyRelease(java.awt.event.KeyEvent.VK_BACK_SPACE)

    pause(1)

    x = input(prompt,"s");
    %This deletes the printed letter and resets back to the prompt. If I
    %did not type "wasd" it will au
    % tomically reset back to the prompt
end

%If I type "quit", the system will type "clear" and "clc" and end the
%program
if x == "quit"
    robot.keyPress(java.awt.event.KeyEvent.VK_C)
    robot.keyRelease(java.awt.event.KeyEvent.VK_C)

    robot.keyPress(java.awt.event.KeyEvent.VK_L)
    robot.keyRelease(java.awt.event.KeyEvent.VK_L)

    robot.keyPress(java.awt.event.KeyEvent.VK_E)
    robot.keyRelease(java.awt.event.KeyEvent.VK_E)

    robot.keyPress(java.awt.event.KeyEvent.VK_A)
    robot.keyRelease(java.awt.event.KeyEvent.VK_A)

    robot.keyPress(java.awt.event.KeyEvent.VK_R)
    robot.keyRelease(java.awt.event.KeyEvent.VK_R)

    pause(1)

    robot.keyPress(java.awt.event.KeyEvent.VK_ENTER)
    robot.keyRelease(java.awt.event.KeyEvent.VK_ENTER)

    pause(1)

    robot.keyPress(java.awt.event.KeyEvent.VK_C)
    robot.keyRelease(java.awt.event.KeyEvent.VK_C)

    robot.keyPress(java.awt.event.KeyEvent.VK_L)
    robot.keyRelease(java.awt.event.KeyEvent.VK_L)

    robot.keyPress(java.awt.event.KeyEvent.VK_C)
    robot.keyRelease(java.awt.event.KeyEvent.VK_C)

    pause(1)

    robot.keyPress(java.awt.event.KeyEvent.VK_ENTER)
    robot.keyRelease(java.awt.event.KeyEvent.VK_ENTER)
end