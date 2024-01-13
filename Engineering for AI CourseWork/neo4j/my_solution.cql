//Task0
//Self-relationship nodes
MATCH (z1:zone)-[r:CONNECTS]->(z2:zone) WHERE z1.id=z2.id RETURN COUNT(r)

//isolated nodes
MATCH (z1:zone)
WHERE NOT (z1:zone)-[:CONNECTS]->()
RETURN COUNT(z1)

//Task 1 (Using louvain algorithm)
CALL gds.graph.create(
  'neo4j-communities-Akash1',
  'zone',
  {
    CONNECTS: {
      type: 'CONNECTS',
      orientation: 'UNDIRECTED',
      properties: 'trips'
    }
  }
)

CALL gds.louvain.stream('neo4j-communities-Akash2', { relationshipWeightProperty: 'trips' })
YIELD nodeId, communityId
RETURN gds.util.asNode(nodeId).id AS zone_id,communityId AS community_id

CALL gds.louvain.stats('neo4j-communities-Akash')
YIELD communityCount

//Task 2 (Using PageRank algorithm)
CALL gds.graph.create(
  'neo4j-centrality',
  'zone',
  'CONNECTS',
  {
    relationshipProperties: 'trips'
  }
)

CALL gds.pageRank.write.estimate('neo4j-centrality', {
  writeProperty: 'pageRank',
  dampingFactor: 0.75,
  relationshipWeighProperty:'trips'
})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory

CALL gds.pageRank.stream('neo4j-centrality')
{
dampingFactor: 0.75,
relationshipWeighProperty:'trips'
}
YIELD nodeId, score
RETURN gds.util.asNode(nodeId).id AS zone_id, score AS centrality_score
ORDER BY score DESC

CALL gds.pageRank.stats('neo4j-centrality', {
  dampingFactor: 0.75,
  relationshipWeighProperty:'trips'
})
YIELD centralityDistribution
RETURN centralityDistribution.max AS max, centralityDistribution.min AS min

//Task 3
//top 3 highest centrality zones per each community:

//Including zones in the 'Manhattan' borough.
MATCH (z:zone)
with z order by z.centrality desc
with z.community as community,collect({zone_id:z.id, centrality:z.centrality}) as zone
UNWIND zone[0..3] AS z1
return z1.zone_id as zone_id ,community as community_id
order by community

//Excluding zones in the 'Manhattan' borough.
MATCH (z:zone)-[r:IN]->(b:borough) WHERE b.name <> 'Manhattan' with z order by z.centrality desc
with z.community as community,collect({zone_id:z.id, centrality:z.centrality}) as zone
UNWIND zone[0..3] AS z1
return z1.zone_id as zone_id ,community as community_id
order by community
