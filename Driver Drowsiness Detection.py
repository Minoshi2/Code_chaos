from imutils.video import VideoStream
from imutils import face_utils
import imutils
import time
import dlib
from cv2 import cv2
import numpy as num
from EAR import EARs
from MAR import MARs
from HeadPose import getHeadSlantDegree
import winsound

# Permitting the camera to get ready
print("Starting camera...")
vs = VideoStream(src=0).start()
# Waits for the execution for 2 seconds
time.sleep(2.0)

width = 1024
height = 768

# iterate over the frames from the video stream
image_coordinates= num.array([
    (359, 391),  # Nose tip
    (399, 561),  # Chin
    (337, 297),  # Left EAR
    (513, 301),  # Right EAR
    (345, 465),  # Left MAR
    (453, 469)  # Right MAR
], dtype="double")

(leftStart, leftEnd) = face_utils.FACIAL_LANDMARKS_IDXS["left_eye"]
(rightStart, rightEnd) = face_utils.FACIAL_LANDMARKS_IDXS["right_eye"]

eye_margin = 0.237
mouth_margin = 0.79
eye_frames = 1
count = 0
Counter=0
FinalWarning = 0
NumberOfWarnings = 2
sendDriversLocation = 0
continuingProgram = 0

# capture the values for mouth positioning
(mStart, mEnd) = (49, 68)

while True:
    # capture the frame from the video stream, rescale it and transform it to grayscale
    cam = cv2.VideoCapture(1)
    frame = vs.read()
    frame = imutils.resize(frame, width=1024, height=768)
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    size = gray.shape

    # detect the number of faces
    values = detect(gray, 0)
    # inspect whether a face is captured,
    # if so, calculate the number of faces in the frame
    if len(values) > 0:
        phrase = "{} face(s) found".format(len(values))
        cv2.putText(frame, phrase, (15, 15),
                    cv2.FONT_HERSHEY_DUPLEX, 0.5, (136, 8, 8), 2)

    # loop over the faces detected
    for value in values:
        # calculate the boundaries of the face and display it on the frame
        (aX, aY, aW, aH) = face_utils.rect_to_bb(value)
        cv2.rectangle(frame, (aX, aY), (aX + aW, aY + aH), (0, 255, 255), 1)
        # compute the landmarks for the face , then
        # transform the landmarks to an array
        arr = predict(gray, value)
        arr = face_utils.shape_to_np(arr)
        # derive the eye coordinates, then utilize the
        # coordinates to calculate the EAR
        lEye = arr[leftStart:leftEnd]
        rEye = arr[rightStart:rightEnd]
        lEAR = EARs(lEye)
        rEAR = EARs(rEye)
        # compute the average EAR for the eyes
        ear = (lEAR + rEAR) / 2.0

        # calculate the convex hull for the both eyes
        leftHull = cv2.convexHull(lEye)
        rightHull = cv2.convexHull(rEye)
        cv2.drawContours(frame, [leftHull], -1, (0, 255, 255), 1)
        cv2.drawContours(frame, [rightHull], -1, (0, 255, 255), 1)
        mouth = arr[mStart:mEnd]

        mouthMAR = MARs(mouth)
        mar = mouthMAR
        # calculate the convex hull for the mouth
        mouthHull = cv2.convexHull(mouth)

        cv2.drawContours(frame, [mouthHull], -1, (0, 255, 0), 1)
        cv2.putText(frame, "Mouth aspect ratio: {:.2f}".format(mar), (675, 18),
                    cv2.FONT_HERSHEY_DUPLEX, 0.7, (0, 255, 255), 2)

        # Display a phrase if mouth is open

        # determine whether the EAR is below the blink
        # margin, if so, increase the blink counts
        cv2.putText(frame, "Eye aspect ratio: {:.2f}".format(ear), (675, 50),
                    cv2.FONT_HERSHEY_DUPLEX, 0.7, (0, 255, 255), 2)
        if ear < eye_margin:
            count += 1
            # if the eyes were closed for a satisfactory amount of times, alert the driver
            if count >= eye_frames:
                cv2.putText(frame, "Eyes Closed!", (520, 20),
                            cv2.FONT_HERSHEY_DUPLEX, 0.7, (0, 255, 255), 2)
                if mar > mouth_margin:

                    if count >= 6:
                        cv2.putText(frame, "", (100, 50),
                                    cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)

                else:
                    if count >= 9:
                        cv2.putText(frame, "High drowsiness alert!", (100, 50),
                                    cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)

                        winsound.PlaySound('alarm.wav', winsound.SND_FILENAME)
                        FinalWarning += 4
            # else the EAR is not below the blink margin
            # so reinitialize the alarm and count
        else:
            count = 0


        if mar > mouth_margin:
            Counter+=1
            cv2.putText(frame, "Yawning!", (820, 65),
                        cv2.FONT_HERSHEY_DUPLEX, 0.7, (0, 255, 255), 2)
            if count >= 9:
                cv2.putText(frame, "Low drowsiness alert!", (100, 50),
                            cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
                winsound.Beep(500, 1000)


        else:
            Counter=0
        # iterate over the landmarks
        for (i, (x, y)) in enumerate(arr):
            if i == 33:
                image_coordinates[0] = num.array([x, y], dtype='double')
                cv2.circle(frame, (x, y), 1, (0, 255, 255), -1)

            elif i == 8:
                image_coordinates[1] = num.array([x, y], dtype='double')
                cv2.circle(frame, (x, y), 1, (0, 255, 255), -1)

            elif i == 36:
                image_coordinates[2] = num.array([x, y], dtype='double')
                cv2.circle(frame, (x, y), 1, (0, 255, 255), -1)

            elif i == 45:
                image_coordinates[3] = num.array([x, y], dtype='double')
                cv2.circle(frame, (x, y), 1, (0, 255, 255), -1)

            elif i == 48:
                image_coordinates[4] = num.array([x, y], dtype='double')
                cv2.circle(frame, (x, y), 1, (0, 255, 255), -1)

            elif i == 54:
                image_coordinates[5] = num.array([x, y], dtype='double')
                cv2.circle(frame, (x, y), 1, (0, 255, 255), -1)

            else:
                cv2.circle(frame, (x, y), 1, (0, 0, 255), -1)


        # Display the co-ordinates of facial features
        for p in image_coordinates:
            cv2.circle(frame, (int(p[0]), int(p[1])), 3, (0, 0, 255), -1)

        (head_slant_degree, initialise_point, finishing_point,
         end_point_alt) = getHeadSlantDegree(size, image_coordinates,height)

        cv2.line(frame, initialise_point, finishing_point, (255, 0, 0), 2)
        cv2.line(frame, initialise_point, end_point_alt, (0, 0, 255), 2)

        if head_slant_degree:
            cv2.putText(frame, 'Head Slant Degree: ' + str(head_slant_degree[0]), (170, 20),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 0, 255), 2)

        # derive the eye coordinates, then utilize the
        # coordinates to calculate the MAR
    cv2.imshow("Frame", frame)

    key = cv2.waitKey(1)

    if key == 27:
        break
cam.release()
cv2.destroyAllWindows()
