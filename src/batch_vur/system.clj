(ns batch-vur.system
  (:require [batch-vur.core :as core]
            [aero.core :refer (read-config)]
            [clojure.java.io :as io]
            [mount.core :refer [defstate] :as mount])
  (:gen-class))



(defstate config
          :start (read-config (io/resource "config.edn") {:profile :docker}))


(defstate onyx-system
          :start (let [tenancy-id (:tenancy-id config)]
                   (core/start-onyx tenancy-id config))
          :stop (core/shutdown-onyx onyx-system))

(defstate jobs
          :start (core/submit-jobs! onyx-system config))

(defn -main[]
   (mount/start))
