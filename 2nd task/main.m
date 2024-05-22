clc
clear

% 네트워크 연결 (TELLO-EF7DB7)

% 드론 연결 확인
my_tello = ryze()

% 드론 제어의 시작(이륙) 
takeoff(my_tello)
pause(2)

% 1. roll 제어: 직진
moveforward(my_tello, 4) % 0.4m/s로 4초 이동
pause(2)

% 2. yaw 제어: 회전(시계 180도)
turn(my_tello, deg2rad(180))
pause(2)

% 3. pitch 제어: 왼쪽으로 이동
moveleft(my_tello, 4)
pause(2)

% 4. yaw 제어: 회전(시계 270도)
turn(my_tello, deg2rad(270))
pause(2)

% 5. pitch 제어: 오른쪽으로 이동
moveright(my_tello, 4)
pause(2)

% 6. 사진 촬영
tello_cam = camera(my_tello)
img = snapshot(tello_cam);
imshow(img)

% 7. yaw 제어: 회전(시계 180도)
turn(my_tello, deg2rad(180))
pause(2)

% 8. roll 제어: 직진
moveforward(my_tello, 4)
pause(2)

% 드론 제어의 끝(착륙)
land(my_tello)
