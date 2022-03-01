import numpy as num
import math
from cv2 import cv2

coordinates = num.array([
    (0.0, 0.0, 0.0),
    (0.0, -330.0, -65.0),
    (-225.0, 170.0, -135.0),
    (225.0, 170.0, -135.0),
    (-150.0, -150.0, -125.0),
    (150.0, -150.0, -125.0)
])


# Determine whether a matrix is justifiable
def rotationModel(P):
    Right = num.transpose(P)
    Id = num.dot(Right, P)
    L = num.identity(3, dtype=P.dtype)
    m = num.linalg.norm(L - Id)
    return m < 1e-6


# Computes matrix angles to identify the rigid body according to fixed co-ordinates
def rotationModelTo3DAngles(P):
    assert (rotationModel(P))
    ln = math.sqrt(P[0, 0] * P[0, 0] + P[1, 0] * P[1, 0])
    single = ln < 1e-6
    if not single:
        a = math.atan2(P[2, 1], P[2, 2])
        b = math.atan2(-P[2, 0], ln)
        c = math.atan2(P[1, 0], P[0, 0])
    else:
        a = math.atan2(-P[1, 2], P[1, 1])
        b = math.atan2(-P[2, 0], ln)
        c = 0
    return num.array([a, b, c])


def getHeadSlantDegree(size, image_points, frame_height):
    focal_length = size[1]
    center = (size[1]/2, size[0]/2)
    camera_matrix = num.array([[focal_length, 0, center[0]], [
        0, focal_length, center[1]], [0, 0, 1]], dtype="double")



    dist_coeffs = num.zeros((4, 1))
    # Presuming no interference
    (_, rotation_vector, translation_vector) = cv2.solvePnP(coordinates, image_points,
                                                                  camera_matrix, dist_coeffs,
                                                                  flags = cv2.SOLVEPNP_ITERATIVE)

    #Display a line from nose finishing point
    (nose_end_point2D, _) = cv2.projectPoints(num.array(
        [(0.0, 0.0, 1000.0)]), rotation_vector, translation_vector, camera_matrix, dist_coeffs)

    rotation_matrix, _ = cv2.Rodrigues(rotation_vector)

    #compute head slant degree
    head_slant_degree = abs(
        [-180] - num.rad2deg([rotationModelTo3DAngles(rotation_matrix)[0]]))


    initialising_coordinate = (int(image_points[0][0]), int(image_points[0][1]))
    finishing_coordinate= (int(nose_end_point2D[0][0][0]), int(nose_end_point2D[0][0][1]))

    ending_point_alternate = (finishing_coordinate[0], frame_height // 2)

    return head_slant_degree, initialising_coordinate, finishing_coordinate, ending_point_alternate
