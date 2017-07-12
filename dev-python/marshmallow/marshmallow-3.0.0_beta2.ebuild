# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_4 )
inherit distutils-r1

DESCRIPTION="A lightweight library for converting complex datatypes to and from native Python datatypes."
HOMEPAGE="https://github.com/marshmallow-code/marshmallow"

MY_PV="3.0.0b2"
SRC_URI="https://pypi.python.org/packages/fa/12/4a837dc26173819a29e713cbfb490a83d5296545abbe53422d7b14604d8f/${PN}-${MY_PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/${PN}-${MY_PV}"

DEPEND=""
RDEPEND="${DEPEND}"
