#
# OnAir
#
export PACKAGES_LIVE_RW_TOKEN="$PACKAGES_RW_TOKEN"
export CI_JOB_TOKEN="$PACKAGES_RW_TOKEN"
export PACKAGES_RW_URI=https://gitlab.onairent.live/api/v4/projects/71/packages/maven
export PACKAGES_LIVE_RW_URI=https://gitlab.onairent.live/api/v4/projects/390/packages/maven
alias v="nvim"
alias k="kubectl"
alias gg="git grep -P -n -w"


function cqlsh(){
  context="${K8_CONTEXT:-dev-hcloud-k8s}"
  namespace="${K8_NS:-pls-cit-be}"
  container="${K8_CONTAINER:-cassandra}"
  pod="${K8_POD:-cassandra}"
  user="${CASSANDRA_USER:-onair}"
  password="${CASSANDRA_PASSWD:-onair}"
  keyspace="${CASSANDRA_KEYSPACE:-onair}"

  kubectl exec -ti \
    --context "$context" \
    -n "$namespace" \
    -c "$container" \
    "$pod" \
    -- \
      cqlsh \
        -u "$user" \
        -p "$password" \
        -k "$keyspace"
}

function cqlshl2(){
  K8_POD="${K8_POD:-pls-cit-cassandra-l2-dc1-l2-r1-sts-0}" \
  CASSANDRA_USER=pls-cit-cassandra-l2 \
  CASSANDRA_PASSWD=qeaUmAHFKXQmqnd \
  CASSANDRA_KEYSPACE=l2 \
  cqlsh
}
function cqlshl3(){
  K8_POD=pls-cit-cassandra-l3-dc1-l3-r1-sts-0 \
  CASSANDRA_USER=pls-cit-cassandra-l3 \
  CASSANDRA_PASSWD=L3qf0MnV2zgIDWhKiAAA \
  CASSANDRA_KEYSPACE=l3 \
  cqlsh
}

function cassandra_dump(){
  context="${K8_CONTEXT:-dev-hcloud-k8s}"
  namespace="${K8_NS:-pls-cit-be}"
  container="${K8_CONTAINER:-cassandra}"
  pod="${K8_POD:-cassandra}"
  user="${CASSANDRA_USER:-onair}"
  password="${CASSANDRA_PASSWD:-onair}"
  keyspace="${CASSANDRA_KEYSPACE:-onair}"
  journal=${1:-}
  entity_id=${2}
  segment=${3}

  kubectl exec -ti \
    --context "$context" \
    -n "$namespace" \
    -c "$container" \
    "$pod" \
    -- \
      cqlsh \
        --no-color \
        -u "$user" \
        -p "$password" \
        -k "$keyspace" \
        -e "SELECT payload_txt FROM journal WHERE id = '${journal}|${entity_id}' AND topic = 'journal_${journal}' AND segment = ${segment};" |\
    sed 1,3d |\
    sed -E 's/^[ \t]*//' |\
    sed -E 's/\([0-9]* rows\)//' |\
    sed '/^[[:space:]]*$/d'

}

function l2_dump(){
  K8_POD="${K8_POD:-pls-cit-cassandra-l2-dc1-l2-r1-sts-0}" \
  CASSANDRA_USER=pls-cit-cassandra-l2 \
  CASSANDRA_PASSWD=qeaUmAHFKXQmqnd \
  CASSANDRA_KEYSPACE=l2 \
  cassandra_dump "$1" "$2" "$3" > "$2.$3.json" 2>&1

  stat -x "$2.$3.json"
}

function l3_dump(){
  K8_POD=pls-cit-cassandra-l3-dc1-l3-r1-sts-0 \
  CASSANDRA_USER=pls-cit-cassandra-l3 \
  CASSANDRA_PASSWD=L3qf0MnV2zgIDWhKiAAA \
  CASSANDRA_KEYSPACE=l3 \
  cassandra_dump "$1" "$2" "$3" > "$2.$3.json" 2>&1

  stat -x "$2.$3.json"
}

function psqlk8s(){
  context="${K8_CONTEXT:-dev-hcloud-k8s}"
  namespace="${K8_NS:-pls-cit-be}"
  container="${K8_CONTAINER:-cassandra}"

  ns="$1"
  awk_print_pod_name='{print $1}'
  like_pod="/$2/$awk_print_pod_name"
  
  kubectl exec -ti \
    --context "$context" \
    -n "$ns" \
    -c postgres \
    $(kubectl --context "$context" -n "$ns" get pods | awk "$like_pod" | head -n 1 ) \
    -- \
      psql \
      -U db_owner_user \
      -d db
}
function pg_dumpk8s(){
	ns="$1"
	awk_print_pod_name='{print $1}'
	like_pod="/$2/$awk_print_pod_name"
	k8sctl exec -ti -n "$ns" $(k8sctl -n "$ns" get pods | awk "$like_pod" | head -n 1 ) -c postgres -- pg_dump -O -U db_owner_user -d db
}
function psqlgcp(){
	ns="$1"
	awk_print_pod_name='{print $1}'
	like_pod="/$2/$awk_print_pod_name"
	k8sctl exec -ti -n "$ns" $(k8sctl -n "$ns" get pods | awk "$like_pod" | head -n 1) -c postgres-util -- psql
}
function pg_dumpgcp(){
	ns="$1"
	awk_print_pod_name='{print $1}'
	like_pod="/$2/$awk_print_pod_name"
	k8sctl exec -ti -n "$ns" $(k8sctl -n "$ns" get pods | awk "$like_pod" | head -n 1) -c postgres-util -- pg_dump -a -O -x -t onair_downstream_game_results -t onair_downstream_player_results -t onair_downstream_player_results_new
}


