#pragma once

namespace edenedge
{
    typedef int VertexIndex;
    typedef int FaceIndex;
    typedef int HalfEdgeIndex;

    struct HalfEdge
    {
        VertexIndex start;
        FaceIndex face;
        HalfEdgeIndex prev;
        HalfEdgeIndex next;
        HalfEdgeIndex opposite;
    };

    template<typename VertexType>
    struct HalfEdgeVertex 
    {
        HalfEdgeIndex outgoing;
        VertexType data;
    };

    struct Face 
    {
        HalfEdgeIndex start;
    };

    template<typename VertexType>
    class HalfEdgeMesh
    {

    };
}