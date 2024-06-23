image1 = imread('사진1.jpg');
image2 = imread('사진2.jpg');
image3 = imread('사진3.jpg');
image4 = imread('사진4.jpg');
image5 = imread('사진5.jpg');

holeCenter1 = find_hole_center(image1);
holeCenter2 = find_hole_center(image2);
holeCenter3 = find_hole_center(image3);
holeCenter4 = find_hole_center(image4);
holeCenter5 = find_hole_center(image5);

function holeCenter = find_hole_center(image)
    % 이미지 HSV 색 공간으로 변환
    hsvImage = rgb2hsv(image);

    % HSV 공간에서 녹색의 임계값 정의
    greenThreshLow = [0.25, 0.40, 0.20]; % 녹색의 낮은 임계값 [색상, 채도, 명도]
    greenThreshHigh = [0.45, 1.00, 1.00]; % 녹색의 높은 임계값 [색상, 채도, 명도]

    % 녹색 영역에 대한 이진 마스크 생성
    greenMask = (hsvImage(:,:,1) >= greenThreshLow(1)) & (hsvImage(:,:,1) <= greenThreshHigh(1)) & ...
                (hsvImage(:,:,2) >= greenThreshLow(2)) & (hsvImage(:,:,2) <= greenThreshHigh(2)) & ...
                (hsvImage(:,:,3) >= greenThreshLow(3)) & (hsvImage(:,:,3) <= greenThreshHigh(3));

    % 모폴로지 연산을 통해 노이즈 제거
    greenMask = imopen(greenMask, strel('rectangle', [5, 5]));
    greenMask = imclose(greenMask, strel('rectangle', [15, 15]));

    % 녹색 영역의 경계 찾기
    props = regionprops(greenMask, 'BoundingBox', 'Centroid');

    % 가장 큰 녹색 영역의 경계 상자 찾기
    if ~isempty(props)
        [~, largestIdx] = max(cellfun(@(x) x(3)*x(4), {props.BoundingBox}));
        boundingBox = props(largestIdx).BoundingBox;

        % 뚫린 부분을 찾기 위해 녹색 영역을 반전
        invertedMask = ~greenMask;

        % 뚫린 부분의 경계 찾기
        holeProps = regionprops(invertedMask, 'BoundingBox', 'Centroid');

        % 뚫린 부분 중 가장 큰 영역 찾기
        holeBoundingBox = [];
        for i = 1:length(holeProps)
            if holeProps(i).BoundingBox(1) > boundingBox(1) && ...
               holeProps(i).BoundingBox(1) + holeProps(i).BoundingBox(3) < boundingBox(1) + boundingBox(3) && ...
               holeProps(i).BoundingBox(2) > boundingBox(2) && ...
               holeProps(i).BoundingBox(2) + holeProps(i).BoundingBox(4) < boundingBox(2) + boundingBox(4)
                holeBoundingBox = holeProps(i).BoundingBox;
                break;
            end
        end

        if ~isempty(holeBoundingBox)
            % 뚫린 부분의 중심 계산
            holeCenter = [holeBoundingBox(1) + holeBoundingBox(3)/2, holeBoundingBox(2) + holeBoundingBox(4)/2];
        else
            holeCenter = [NaN, NaN];
            warning('사각형이 감지되지 않았습니다.');
        end
    else
        holeCenter = [NaN, NaN];
        warning('녹색 영역이 감지되지 않았습니다.');
    end

    % 중점 좌표 출력
    fprintf('중점 좌표: (%.2f, %.2f)\n', holeCenter(1), holeCenter(2));

    % 중심점이 표시된 이미지 출력
    imshow(image);
    hold on;
    if ~isnan(holeCenter(1))
        plot(holeCenter(1), holeCenter(2), 'r+', 'MarkerSize', 30, 'LineWidth', 2);
        title(sprintf('중점: (%.2f, %.2f)', holeCenter(1), holeCenter(2)));
    else
        title('사각형이 감지되지 않았습니다.');
    end
    hold off;
end
