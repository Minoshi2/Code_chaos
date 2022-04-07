from scipy.spatial import distance as dis


def MARs(mouth):
    # calculate the euclidean distances of the
    # vertical and horizontal bounds of the mouth
    I = dis.euclidean(mouth[2], mouth[10])
    J = dis.euclidean(mouth[4], mouth[8])

    K = dis.euclidean(mouth[0], mouth[6])

    mouthAspectRatio = (I + J) / (2.0 * K)

    # return the MAR
    return mouthAspectRatio
