# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit vala autotools-multilib

DESCRIPTION="Widgets and other objects used for indicators"
HOMEPAGE="https://launchpad.net/ido"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/ido_13.10.0%2B${PV}.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="3"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc static-libs"

RDEPEND="
	>=dev-libs/glib-2.37:2[${MULTILIB_USEDEP}]
	>=x11-libs/gtk+-3.8.2:3[ubuntu,${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig[${MULTILIB_USEDEP}]
	doc? ( dev-util/gtk-doc )"

DOCS=( AUTHORS COPYING ChangeLog NEWS README TODO )
S="${WORKDIR}/ido-13.10.0+${PV}"
AUTOTOOLS_AUTORECONF=1

src_prepare() {
	vala_src_prepare
	autotools-utils_src_prepare
}

multilib_src_configure() {
	autotools-utils_src_configure VALA_API_GEN="${VAPIGEN}"
}
