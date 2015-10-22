resource agalaxy {
    disk {
        resync-rate 100M;
        al-extents 2003; # nearest prime to 2000
        fencing resource-only;
    }
    handlers {
        fence-peer "/usr/lib/drbd/crm-fence-peer.sh";
        after-resync-target "/usr/lib/drbd/crm-unfence-peer.sh";
        #split-brain "<to be written>";
    }
    net {
        #after-sb-0pri: discard-younger-primary;
        #after-sb-1pri: <to be determined>
        #after-sb-2pri: <to be determined>
    }
    on ${HA_LOCAL_HOST} {
        address     ${HA_LOCAL_IP}:7788;
        volume 0 {
            device      ${HA_DRBD_DEV_0};
            disk        ${HA_BLOCK_DEV_0};
            meta-disk   internal;
        }
        volume 1 {
            device      ${HA_DRBD_DEV_1};
            disk        ${HA_BLOCK_DEV_1};
            meta-disk   internal;
        }
    }
    on ${HA_PEER_HOST} {
        address     ${HA_PEER_IP}:7788;
        volume 0 {
            device      ${HA_DRBD_DEV_0};
            disk        ${HA_BLOCK_DEV_0};
            meta-disk   internal;
        }
        volume 1 {
            device      ${HA_DRBD_DEV_1};
            disk        ${HA_BLOCK_DEV_1};
            meta-disk   internal;
        }
    }
}
