% 현재 날짜와 시간 입력
currentDate = input('현재 날짜와 시간을 "yyyy-mm-dd HH:MM" 형식으로 입력하세요: ', 's');
% 입력된 날짜와 시간을 datetime 형태로 변환
currentDateTime = datetime(currentDate, 'InputFormat', 'yyyy-MM-dd HH:mm');

% 시간 단위(H)입력
hoursToAdd = input('추가할 시간(H)을 입력하세요: ');

% 입력받은 시간을 현재 날짜/시간에 추가
finalDateTime = currentDateTime + hours(hoursToAdd);

% 결과 출력
finalDateTime.Format = 'yyyy-MM-dd HH:mm';
disp(['계산된 날짜와 시간: ', char(finalDateTime)]);

