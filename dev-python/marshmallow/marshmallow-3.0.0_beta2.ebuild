# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )
inherit distutils-r1

DESCRIPTION="Library for converting complex datatypes to and from native Python datatypes"
HOMEPAGE="https://github.com/marshmallow-code/marshmallow"

MY_PV="3.0.0b2"
#SRC_URI="https://pypi.python.org/packages/fa/12/4a837dc26173819a29e713cbfb490a83d5296545abbe53422d7b14604d8f/${PN}-${MY_PV}.tar.gz"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="test"

S="${WORKDIR}/${PN}-${MY_PV}"

DEPEND="
	test? ( 
		dev-python/pytest[${PYTHON_USEDEP}] 
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/simplejson[${PYTHON_USEDEP}]
		>=dev-python/tox-1.5.0[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

python_test() {
	pytest -v || die "test failed with ${EPYTHON}"
}
