from scipy.spatial import distance as dis


def EARs(eye):
    # calculate the euclidean distances of the
    # vertical and horizontal bounds of the eye
    I = dis.euclidean(eye[1], eye[5])
    J = dis.euclidean(eye[2], eye[4])

    K = dis.euclidean(eye[0], eye[3])
    eyeAspectRatio = (I + J) / (2.0 * K)
    # return the EAR
    return eyeAspectRatio
