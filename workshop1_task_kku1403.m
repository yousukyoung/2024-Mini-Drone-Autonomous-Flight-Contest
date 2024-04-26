% 현재 시각으로부터 X 시간 후의 시각 계산

fprintf("<현재 시간으로부터 X 시간 후의 날짜와 시간을 계산합니다>\n\n")
% 현재 시간 입력
current = input("현재 시간을 yyyy-mm-dd hh:mm 형식으로 입력하세요.\n>> ", 's');

% x 입력 받기
x = input("X를 입력하세요\n>> ");

% X 시간 후의 시각 계산
future = datetime(current, 'InputFormat', 'yyyy-MM-dd HH:mm') + hours(x);

% 결과출력
fprintf("%d 시간 후의 시각\n>> %s 입니다.", x, future);


