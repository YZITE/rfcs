BEGIN;

CREATE TABLE IF NOT EXISTS fsbackends (
    uuid    BLOB(16) NOT NULL PRIMARY KEY,
    server  BLOB(16) NOT NULL, -- u128
    backend TEXT NOT NULL,
);

CREATE TABLE IF NOT EXISTS objects (
    uuid        BLOB(16) NOT NULL PRIMARY KEY,
    sb_cur      BLOB(16) NOT NULL, -- u128
    sb_next     BLOB(16) NULL,     -- u128
    skip_count  TINYINT NOT NULL,  -- u8
    mtime_secs  BLOB(8) NOT NULL,  -- u64
    mtime_nsecs INTEGER NOT NULL,  -- u32
);

COMMIT;
