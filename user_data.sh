MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: text/x-shellscript; charset="us-ascii"
#!/bin/bash
set -ex
B64_CLUSTER_CA=LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJUmU4NENuOFBEY0l3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRBNU1USXdOelF6TXpWYUZ3MHpOREE1TVRBd056UTRNelZhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUURaeWJGZk8yUDhHUGZ0bnNJK0FDTHpVMTlaamkxdTBjUitYcjEvcGFBVG44ZkxqMFZ3MkF6dlAwdG8KVWVDeXFWTXB2bnVzTUpBWCtkdmlBMG5lS2IvUlFFQnNnWGNNUGYrOEUzRllBanhTMElrOEFtYWFTeXJwREUyawpncHRNNnpLaUNzSUwrdWRGSXNJV2lhSHZTNjA1ZDRCVjZ1ekZ1R1VOWUw3RnQydWtxa2Z0WlZYUWRvQUpMUExpClpaaDBFNW15RzkwRUJubmlDVzBHZjhqeWxHU1NMaFZXZ1RCNE9oKzNCQnlKYXZ6ODhWT2lhcDkrM3pZQlRSWVcKRUtWd28vK1JKamdXWHRTQWVJelQ2dDhFNzBTVkpaYlpseTFpNXdDWERndEk2clB4SUxBTFNucUdHSWNCWll3bwptbUZkK0tYSFc5aHErc1pQZlBDSUUrZHQyb2lGQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJTbjk0U3NUL0tWRVAyczZ2RHpPZHNiVUt5MkR6QVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQzFzVVcveFFjaApyaFNEVENNVit5WE1GVGtiWG95V3hqWnU0Z1EvMnBGOVI4SnRsbi9rTFJadk93VHlUTlFIZy9LRzU3SWdlcWZHCnI4WEFWTXh2Vm51b0pvY0c5dlFxWDBKM1ZJRk5pNTFTRVJwemNLd1QwcVROeHRKUGlSbU1ZZk11dFczOWJYb2sKRDRiYis2dzdEdTZOZlZPT0tpaTlqNVNzbUhZSW45VmgwaWRnQ1RTd3NWUmxrQm44Z1ZpNm9IQTh4Z0tjdFBXMQp4UGV3bmsvSHRhWFZXVXJjMXFyU2t5TEhmTUJMcTQ5Y1krWG5rY0JHQ0tBbkwwdmxrVU5ROEVwbjZHMWFjYVJZCmhyRmwzdjUyMXdFMERSNE42MmVHa3BYVERJcWdRMXBiVUNVejlGVnlIYjE5Y2oyb3BvWWxmL3NPTHRJcWpPSHoKVjRnOUZlbXgwMXFOCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
API_SERVER_URL=https://6434793D9C7B4BD56CDC4C367D49347F.gr7.ap-south-1.eks.amazonaws.com
K8S_CLUSTER_DNS_IP=172.20.0.10
/etc/eks/bootstrap.sh my-cluster --kubelet-extra-args '--node-labels=eks.amazonaws.com/nodegroup-image=ami-061be35eef72162eb,eks.amazonaws.com/capacityType=ON_DEMAND,eks.amazonaws.com/nodegroup=my-nodes-group --max-pods=30' --b64-cluster-ca $B64_CLUSTER_CA --apiserver-endpoint $API_SERVER_URL --dns-cluster-ip $K8S_CLUSTER_DNS_IP --use-max-pods false

--//--
