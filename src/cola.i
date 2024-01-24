/* This is a SWIG interface file for generating interfaces to the Adpatagrams
 * libraries for languages other than C++.  It has currently been tested from
 * Java and Python, but could be adapted for other languages.
 */

/* File : adaptagrams.i */
%module(directors="1") adaptagrams

/* Allow target language to subclass and implement virtual methods for
 * these classes.
 */
%feature("director") Avoid::Router;
%feature("director") cola::TestConvergence;

%{
#include <vector>
#include <libvpsc/rectangle.h>
#include <libvpsc/assertions.h>
#include <libcola/cola.h>
#include <libcola/cluster.h>
#include <libcola/convex_hull.h>
#include <libcola/compound_constraints.h>
#include <libcola/exceptions.h>
#include <libtopology/topology_graph.h>
#include <libtopology/cola_topology_addon.h>
#include <libavoid/libavoid.h>
#include <libtopology/orthogonal_topology.h>
#include "libavoid/debughandler.h"
#include "libavoid/hyperedge.h"

/* Includes the header in the wrapper code */

using namespace Avoid;
using namespace cola;
using namespace hull;
using namespace vpsc;
using namespace topology;
%}

%ignore Avoid::XDIM;
%ignore Avoid::YDIM;
%ignore Avoid::Point::operator[];
%ignore cola::PreIteration::operator();
%ignore cola::PreIteration::locksNotUsed;
//%ignore cola::TestConvergence::operator();
%ignore operator<<(std::ostream &os, vpsc::Rectangle const &r);
%ignore vpsc::Rectangle::setXBorder(double);
%ignore vpsc::Rectangle::setYBorder(double);
%ignore vpsc::assertNoOverlaps(const Rectangles& rs);
%ignore Avoid::Point::operator==(const Point&) const;
%ignore Avoid::Point::operator!=(const Point&) const;
%ignore Avoid::Point::operator<(const Point&) const;
%ignore Avoid::Point::operator-(const Point&) const;
%ignore Avoid::Point::operator+(const Point&) const;
%ignore Avoid::ShapeConnectionPin::operator<(const ShapeConnectionPin& rhs) const;
%ignore Avoid::ShapeConnectionPin::operator==(const ShapeConnectionPin& rhs) const;
%ignore Avoid::CmpConnPinPtr::operator()(const ShapeConnectionPin *lhs, const ShapeConnectionPin *rhs) const;
%ignore cola::SubConstraint;
%ignore cola::SubConstraintAlternatives;
%ignore cola::SubConstraintInfo;
%ignore std::vector<cola::SubConstraintInfo>;
%ignore cola::NonOverlapConstraints;
%ignore cola::Resize::Resize();
%ignore vpsc::Constraint::Constraint();
%ignore topology::Segment;
%ignore topology::EdgePoint::inSegment;
%ignore topology::EdgePoint::outSegment;
%ignore topology::EdgePoint::bendConstraint;
%ignore topology::EdgePoint::prune;
%ignore topology::EdgePoint::getBendConstraint(std::vector<TopologyConstraint*>* ts);
%ignore topology::EdgePoint::createBendConstraint();
%ignore topology::EdgePoint::deleteBendConstraint();
%ignore topology::Edge::firstSegment;
%ignore topology::Edge::lastSegment;
%ignore topology::Edge::getTopologyConstraints(std::vector<TopologyConstraint*>* ts) const;
%ignore topology::Edge::getRoute() const;
%ignore topology::Edge::toString() const;
%ignore topology::Edge::toString() const;
%ignore topology::assertConvexBends(const Edges&);
%ignore topology::assertNoSegmentRectIntersection(const Nodes&, const Edges&);
%ignore topology::assertNoZeroLengthEdgeSegments(const Edges& es);
%ignore topology::compute_stress(const Edges&);
%ignore topology::printEdges(const Edges&);
#ifdef SWIGJAVASCRIPT
%ignore *::getCurrSubConstraintAlternatives;
%ignore *::printCreationCode;
%ignore *::outputToSVG;
%ignore *::outputCode;
%ignore *::outputDeletionCode;
%ignore VertID::operator<<;
#endif

%include "std_string.i"
%include "std_vector.i"
%include "std_deque.i"
%include "std_pair.i"
%include "std_map.i"
// %include "std_set.i"
// %include "std_list.i"

/* We have a problem where in garbage collected languages like Java and Python,
 * objects that appear to no longer be used and go out of scope can cause 
 * their corresponding internal C++ instances to be freed prematurely.  
 * For this reason we generate empty finialise methods for the following 
 * classes and clean them up later.
 *
 * For libavoid, the Router instance takes ownership of these objects and 
 * deletes them when it is freed.  For the cola/vpsc classes, a Java/Python
 * user can call ConstrainedFDLayout::freeAssociatedObjects() to free this 
 * memory.
 */
%nodefaultdtor vpsc::Rectangle;
%nodefaultdtor cola::CompoundConstraint;
%nodefaultdtor cola::AlignmentConstraint;
%nodefaultdtor cola::BoundaryConstraint;
%nodefaultdtor cola::DistributionConstraint;
%nodefaultdtor cola::MultiSeparationConstraint;
%nodefaultdtor cola::PageBoundaryConstraints;
%nodefaultdtor cola::SeparationConstraint;
%nodefaultdtor cola::OrthogonalEdgeConstraint;
%nodefaultdtor cola::FixedRelativeConstraint;
%nodefaultdtor cola::Cluster;
%nodefaultdtor cola::RootCluster;
%nodefaultdtor cola::ConvexCluster;
%nodefaultdtor cola::RectangularCluster;
%nodefaultdtor Avoid::ShapeRef;
%nodefaultdtor Avoid::ConnRef;
%nodefaultdtor Avoid::ClusterRef;
%nodefaultdtor Avoid::JunctionRef;
%nodefaultdtor Avoid::Obstacle;
%nodefaultdtor Avoid::ShapeConnectionPin;
%nodefaultdtor cola::PreIteration;
%nodefaultdtor cola::TestConvergence;
%nodefaultdtor cola::Lock;
%nodefaultdtor cola::Resize;
%nodefaultdtor topology::Node;
%nodefaultdtor topology::Edge;
%nodefaultdtor topology::EdgePoint;
%nodefaultdtor topology::ColaTopologyAddon;

%rename(AvoidBox) Avoid::Box;
%rename(AvoidEdge) Avoid::Edge;
%rename(AvoidRectangle) Avoid::Rectangle;
%rename(AvoidTopologyAddonInterface) Avoid::TopologyAddonInterface;
%rename(ColaTestConvergenceOperator) cola::TestConvergence::operator();
%rename(getVarConst) topology::Node::getVar() const;

#ifdef SWIGJAVASCRIPT
%rename(setMarginBox) cola::RectangularCluster::setMargin(const cola::Box margin);
%rename(setPaddingBox) cola::RectangularCluster::setPadding(const cola::Box margin);
%rename(__assign__)     operator=;
%rename(__eq__)         operator==;
%rename(__ne__)         operator!=;
%rename(__lt__)         operator<;
%rename(__add__)        operator+;
%rename(__sub__)        operator-;
%rename(__preincr__)    operator++;
%rename(__lshift__)     operator<<;
#endif

/* Parse the header file to generate wrappers */

%include "libvpsc/rectangle.h"
%include "libvpsc/assertions.h"
%include "libcola/compound_constraints.h"

%include "libcola/box.h"
%include "libcola/cola.h"
%include "libcola/cluster.h"
%include "libcola/convex_hull.h"
%include "libcola/exceptions.h"

%include "libavoid/dllexport.h"
%include "libavoid/debughandler.h"
%include "libavoid/hyperedge.h"
%include "libavoid/geomtypes.h"
%include "libavoid/geometry.h"
%include "libavoid/connend.h"
%include "libavoid/vertices.h"
%include "libavoid/graph.h"
%include "libavoid/connector.h"
%include "libavoid/router.h"
%include "libavoid/obstacle.h"
%include "libavoid/shape.h"
%include "libavoid/junction.h"
%include "libavoid/viscluster.h"
%include "libavoid/connectionpin.h"

%include "libtopology/topology_graph.h"
%include "libtopology/cola_topology_addon.h"
%include "libtopology/orthogonal_topology.h"

// Templates

%template(Chars) std::vector<char>;
%template(Unsigneds) std::vector<unsigned>;
%template(Doubles) std::vector<double>;
// %template(UnsignedSet) std::set<unsigned>;
// %template(UnsignedList) std::list<unsigned>;
// %template(UnsignedIntSet) std::set<unsigned int>;
%template(UnsignedPair) std::pair<unsigned,unsigned>;
%template(UnsignedPairs) std::vector<std::pair<unsigned,unsigned>>;
%template(ListOfNodeIndexes) std::vector<std::vector<unsigned>>;
%template(DesiredPositionInDim) std::pair<unsigned,double>;
%template(ColaDesiredPositionsInDim) std::vector<std::pair<unsigned,double>>;

%template(UnsatisfiableConstraintInfoPtrs) std::vector<cola::UnsatisfiableConstraintInfo *>;
%template(CompoundConstraintPtrs) std::vector<cola::CompoundConstraint*>;
%template(ColaLocks) std::vector<cola::Lock>;
%template(ColaResizes) std::vector<cola::Resize>;
%template(ColaDesiredPositions) std::vector<cola::DesiredPosition>;
%template(ColaClusters) std::vector<cola::Cluster*>;

%template(RectanglePtrs) std::vector<vpsc::Rectangle*>;
%template(VariablePtrs) std::vector<vpsc::Variable*>;
%template(ConstraintPtrs) std::vector<vpsc::Constraints*>;

%template(AvoidPoints) std::vector<Avoid::Point>;
%template(AvoidCheckpoint) std::pair<size_t, Avoid::Point>;
%template(AvoidCheckpoints) std::vector<Avoid::Checkpoint>;
%template(PtConnPtrPair) std::pair<Avoid::Point*, Avoid::ConnRef*>;
%template(PointRepVector) std::vector<Avoid::PtConnPtrPair>;
%template(PtOrderMap) std::map<Avoid::Point,Avoid::PtOrder>;
%template(SharedPathList) std::vector<std::vector<Avoid::Point>>;
%template(PolygonRefs) std::vector<std::pair<const Avoid::Polygon *, unsigned short>>;
%template(VertIDPair) std::pair<Avoid::VertID, Avoid::VertID>;
%template(PointPair) std::pair<Avoid::Point, Avoid::Point>;
// %template(PointSet) std::set<Avoid::Point>;
// %template(LineReps) std::list<Avoid::LineRep>;
// %template(ConnRefList) std::list<Avoid::ConnRef*>;
// %template(ObstacleList) std::list<Avoid::Obstacle*>;
// %template(ClusterRefList) std::list<<Avoid::ClusterRef*>;
// %template(ContainsMap) std::map<Avoid::VertID, Avoid::ShapeSet>;

%template(TopologyEdgePtrs) std::vector<topology::Edge*>;
%template(TopologyNodePtrs) std::vector<topology::Node*>;
%template(TopologyEdgePointPtrs) std::vector<topology::EdgePoint*>;
%template(TopologyEdgePointConstPtrs) std::vector<const topology::EdgePoint*>;

// Typemaps

#ifdef SWIGTYPESCRIPT
%typemap(ts) size_t "number";
%typemap(ts) std::vector<char>, std::vector<char>*, std::vector<char>& "Chars";
%typemap(ts) std::vector<double>, std::vector<double>*, std::vector<double>& "Doubles";
%typemap(ts) std::vector<unsigned>, std::vector<unsigned>*, std::vector<unsigned>& "Unsigneds";
// %typemap(ts) std::set<unsigned>, std::set<unsigned>*, std::set<unsigned>& "UnsignedSet";
// %typemap(ts) std::list<unsigned>, std::list<unsigned>*, std::list<unsigned>& "UnsignedList";
%typemap(ts) std::pair<unsigned,unsigned>, std::pair<unsigned,unsigned>*, std::pair<unsigned,unsigned>& "UnsignedPair";
%typemap(ts) std::vector<std::pair<unsigned,unsigned>>, std::vector<std::pair<unsigned,unsigned>>*, std::vector<std::pair<unsigned,unsigned>>& "UnsignedPairs";

%typemap(ts) vpsc::Variable*, vpsc::Variable& "Variable";
%typemap(ts) vpsc::Constraint*, vpsc::Constraint& "Constraint";
%typemap(ts) std::vector<vpsc::Variable*>, std::vector<vpsc::Variable*>*, std::vector<vpsc::Variable*>& "VariablePtrs";
%typemap(ts) std::vector<vpsc::Rectangle*>, std::vector<vpsc::Rectangle*>*, std::vector<vpsc::Rectangle*>& "RectanglePtrs";
// %typemap(ts) std::vector<vpsc::Constraint*> "ConstraintPtrs";

%typemap(ts) Avoid::Point*, Avoid::Point& "Point";
%typemap(ts) Avoid::Router*, Avoid::Router& "Router";
%typemap(ts) Avoid::VertInf*, Avoid::VertInf& "VertInf";
%typemap(ts) Avoid::ConnRef*, Avoid::ConnRef& "ConnRef";
%typemap(ts) Avoid::Polygon*, Avoid::Polygon& "Polygon";
%typemap(ts) Avoid::Obstacle*, Avoid::Obstacle& "Obstacle";
%typemap(ts) Avoid::ShapeRef*, Avoid::ShapeRef& "ShapeRef";
%typemap(ts) Avoid::ClusterRef*, Avoid::ClusterRef& "ClusterRef";
%typemap(ts) Avoid::JunctionRef*, Avoid::JunctionRef& "JunctionRef";
%typemap(ts) std::vector<Avoid::Point>, std::vector<Avoid::Point>*, std::vector<Avoid::Point>& "AvoidPoints";
%typemap(ts) std::vector<Avoid::Checkpoint>, std::vector<Avoid::Checkpoint>*, std::vector<Avoid::Checkpoint>& "Checkpoints";
// %typemap(ts) std::list<Avoid::ConnRef*>, std::list<Avoid::ConnRef*>*, std::list<Avoid::ConnRef*>& "ConnRefList";
// %typemap(ts) std::list<Avoid::Obstacle*>, std::list<Avoid::Obstacle*>*, std::list<Avoid::Obstacle*>& "ObstacleList";
// %typemap(ts) std::list<Avoid::ClusterRef*>, std::list<Avoid::ClusterRef*>*, std::list<Avoid::ClusterRef*>& "ClusterRefList";
// %typemap(ts) std::map<Avoid::VertID, Avoid::ShapeSet> "ContainsMap";
%typemap(ts) std::pair<Avoid::Point*, Avoid::ConnRef*>, std::pair<Avoid::Point*, Avoid::ConnRef*>*, std::pair<Avoid::Point*, Avoid::ConnRef*>& "PtConnPtrPair";
%typemap(ts) std::vector<Avoid::PtConnPtrPair>, std::vector<Avoid::PtConnPtrPair>*, std::vector<Avoid::PtConnPtrPair>& "PointRepVector";
%typemap(ts) std::map<Avoid::Point,Avoid::PtOrder>, std::map<Avoid::Point,Avoid::PtOrder>*, std::map<Avoid::Point,Avoid::PtOrder>& "PtOrderMap";
%typemap(ts) std::vector<std::vector<Avoid::Point>>, std::vector<std::vector<Avoid::Point>>*, std::vector<std::vector<Avoid::Point>>& "SharedPathList";
%typemap(ts) std::vector<std::pair<const Avoid::Polygon *, unsigned short>> "PolygonRefs";
%typemap(ts) std::pair<Avoid::VertID, Avoid::VertID> "VertIDPair";
%typemap(ts) std::pair<Avoid::Point, Avoid::Point> "PointPair";

%typemap(ts) cola::RootCluster*, cola::RootCluster& "RootCluster";
%typemap(ts) cola::ConstrainedFDLayout*, cola::ConstrainedFDLayout& "ConstrainedFDLayout";
%typemap(ts) std::vector<cola::Lock>, std::vector<cola::Lock>*, std::vector<cola::Lock>& "ColaLocks";
%typemap(ts) std::vector<cola::Resize>, std::vector<cola::Resize>*, std::vector<cola::Resize>& "ColaResizes";
%typemap(ts) std::vector<cola::Cluster*>, std::vector<cola::Cluster*>*, std::vector<cola::Cluster*>& "ColaClusters";
%typemap(ts) std::vector<cola::NodeIndexes>, std::vector<cola::NodeIndexes>*, std::vector<cola::NodeIndexes>& "ListOfNodeIndexes";
%typemap(ts) std::vector<cola::DesiredPosition>, std::vector<cola::DesiredPosition>*, std::vector<cola::DesiredPosition>& "ColaDesiredPositions";
%typemap(ts) std::vector<cola::CompoundConstraint*>, std::vector<cola::CompoundConstraint*>*, std::vector<cola::CompoundConstraint*>& "CompoundConstraintPtrs";
%typemap(ts) std::vector<cola::DesiredPositionInDim>, std::vector<cola::DesiredPositionInDim>*, std::vector<cola::DesiredPositionInDim>& "DesiredPositionsInDim";
%typemap(ts) std::vector<cola::UnsatisfiableConstraintInfo*>, std::vector<cola::UnsatisfiableConstraintInfo*>*, std::vector<cola::UnsatisfiableConstraintInfo*>& "UnsatisfiableConstraintInfoPtrs";

%typemap(ts) std::vector<topology::Node*>, std::vector<topology::Node*>*, std::vector<topology::Node*>& "TopologyNodePtrs";
%typemap(ts) std::vector<topology::Edge*>, std::vector<topology::Edge*>*, std::vector<topology::Edge*>& "TopologyEdgePtrs";
%typemap(ts) std::vector<topology::EdgePoint*>, std::vector<topology::EdgePoint*>*, std::vector<topology::EdgePoint*>& "TopologyEdgePointPtrs";
%typemap(ts) std::vector<const topology::EdgePoint*>, std::vector<const topology::EdgePoint*>*, std::vector<const topology::EdgePoint*>& "TopologyEdgePointConstPtrs";
#endif
