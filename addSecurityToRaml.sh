set -e

TARGET_FILE="./WebContent/api.raml"
CAT="/bin/cat"
TEMPFILE=`mktemp`

$CAT <<ENDTEXT > ${TEMPFILE}
securitySchemes:
  - userKey:
      description: User Key for API authentication
      type: x-user-key
      describedBy:
        headers:
          Authentication:
            type: string
securedBy: [userKey]
ENDTEXT

# Add security Scheme after "protocols:"
sed -i '' "/protocols.*/r ${TEMPFILE}" ${TARGET_FILE}

# Remove "headers:\nAuthorization:" from the parameters
sed -i '' '/headers:/N;/Authorization:/d' ${TARGET_FILE}

echo Security Definition added to ${TARGET_FILE} successfully