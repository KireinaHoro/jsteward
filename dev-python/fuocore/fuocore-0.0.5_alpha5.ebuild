# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_4 )
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1

DESCRIPTION="Extensible music player with batteries included"
HOMEPAGE="https://github.com/cosven/feeluown-core"

MY_PV="0.0.5a5"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="test"

DEPEND="
	dev-python/aiozmq[${PYTHON_USEDEP}]
	>=dev-python/april-0.0.1_alpha4[${PYTHON_USEDEP}]
	>=dev-python/beautifulsoup-4.5.3[${PYTHON_USEDEP}]
	dev-python/fuzzywuzzy[${PYTHON_USEDEP}]
	>=dev-python/marshmallow-2.13.5[${PYTHON_USEDEP}]
	dev-python/msgpack[${PYTHON_USEDEP}]
	>=dev-python/pycrypto-2.6.1[${PYTHON_USEDEP}]
	dev-python/pytest-runner[${PYTHON_USEDEP}]
	>=dev-python/python-levenshtein-0.12.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.13.0[${PYTHON_USEDEP}]
	>=media-libs/mutagen-1.37[${PYTHON_USEDEP}]
	media-video/mpv[libmpv]
	test? ( 
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

python_test() {
	esetup.py test
}
